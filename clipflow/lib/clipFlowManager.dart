import 'dart:io';

import 'package:clipflow/clipflow_storage.dart';
import 'package:clipflow/constants.dart';
import 'package:clipflow/enums.dart';
import 'package:clipflow/exceptions.dart';
import 'package:clipflow/extensions.dart';
import 'package:clipflow/models.dart';
import 'package:clipflow/typedefs.dart';
import 'package:yaml/yaml.dart';

class ClipflowManager {
  final ClipflowStorage _storage;

  ClipflowManager(this._storage);

  void capture(String content) {
    final item = ClipItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      type: content.detectType(),
      textContent: content,
    );
    _storage.save(item);
  }

  void list({int limit = kDefaultListLimit}) {
    final items = _storage.items.take(limit).toList();

    if (items.isEmpty) {
      print('\n No items in history yet!');
      print('');
      print('Try clipflow --capture "your text here"');
      return;
    }

    final actualLimit = items.length < limit ? items.length : limit;
    print('\nClipboard history (Last $actualLimit items)');
    print('=' * 100);
    for (var i = 0; i < items.length; i++) {
      print(items[i].toListItem(i));
    }
    print('=' * 100);
    print('');
  }

  ClipItem? getItemAt(int index) {
    if (index < 0 || index >= _storage.items.length) {
      return null;
    }
    return _storage.items[index];
  }

  List<ClipItem> search(String query) {
    return _storage.items.where((item) => item.hasMatches(query)).toList();
  }

  Future<void> delete(int index) async {
    final item = getItemAt(index);
    if (item == null) {
      throw InvalidIndexException(index, _storage.items.length);
    }

    await _storage.deleteItem(item.id);
    print('Deleted: ${item.textContent.preview}');
  }

  void showStats() {
    final stats = _getStats();

    print('\n📊 CLIPFLOW STATISTICS');
    print('═' * 70);
    print('Total Items:        ${stats.totalItems}');
    print('├─ 📝 Text:         ${stats.textItems}');
    print('├─ 💻 Code:         ${stats.codeItems}');
    print('├─ 🔗 URLs:         ${stats.urlItems}');
    print('└─ 📊 JSON:         ${stats.jsonItems}');
    print('═' * 70);
    print('');
  }

  ClipStats _getStats() {
    final items = _storage.items;

    if (items.isEmpty) {
      return (
        totalItems: 0,
        textItems: 0,
        codeItems: 0,
        urlItems: 0,
        jsonItems: 0,
      );
    }

    return (
      totalItems: items.length,
      textItems: items.where((i) => i.type == ClipType.textType).length,
      codeItems: items.where((i) => i.type == ClipType.codeType).length,
      urlItems: items.where((i) => i.type == ClipType.urlType).length,
      jsonItems: items.where((i) => i.type == ClipType.jsonType).length,
    );
  }

  Future<String> getAppVersion() async {
    final pubspecFile = File('pubspec.yaml');

    final content = await pubspecFile.readAsString();
    final yaml = loadYaml(content);

    if (yaml is YamlMap) {
      final version = yaml['version'];
      if (version is String && version.isNotEmpty) {
        return version;
      }
    }

    return '0.0.0';
  }
}
