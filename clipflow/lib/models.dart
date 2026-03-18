import 'package:clipflow/enums.dart';
import 'package:clipflow/mixins.dart';
import 'package:clipflow/models.dart';

class ClipItem with Searchable {
  final String id;
  final DateTime timestamp;
  final ClipType type;

  @override
  final String textContent;

  ClipItem({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.textContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'type': switch (type) {
        ClipType.textType => 'text',
        ClipType.codeType => 'code',
        ClipType.urlType => 'url',
        ClipType.jsonType => 'json',
      },
      'textContent': textContent,
    };
  }

  factory ClipItem.fromJson(Map<String, dynamic> json) {
    return ClipItem(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      type: switch (json['type']) {
        'text' => ClipType.textType,
        'code' => ClipType.codeType,
        'url' => ClipType.urlType,
        'json' => ClipType.jsonType,
        _ => ClipType.textType,
      },
      textContent: json['textContent'],
    );
  }

  String toListItem(int index) {
    final timeStr = timestamp.timeAgo().padRight(10);
    final typeDisplay = '${type.emoji} ${type.label}'.padRight(10);
    return '$index. $typeDisplay │ $timeStr | ${textContent.preview} ';
  }

  void displayFull() {
    print('\n${'=' * 70}');
    print('${type.emoji} CLIP ITEM #$id');
    print('-' * 70);
    print('Type: ${type.label}');
    print('Created: ${timestamp.toReadable()} (${timestamp.timeAgo()})');
    print('-' * 70);
    print('CONTENT:');
    print(textContent);
    print('=' * 70);
  }
}
