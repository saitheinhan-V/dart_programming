import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:args/args.dart';
import 'package:clipflow/clipflow_manager.dart';
import 'package:clipflow/clipflow_storage.dart';
import 'package:clipflow/constants.dart';
import 'package:clipflow/exceptions.dart';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'capture',
      abbr: 'c',
      help: 'Capture text to clipboard history (interactive)',
      negatable: false,
    )
    ..addOption(
      'list',
      abbr: 'l',
      help: 'List recent items',
      valueHelp: 'count',
      defaultsTo: '$kDefaultListLimit',
    )
    ..addOption(
      'view',
      help: 'View full content of an item',
      valueHelp: 'index',
    )
    ..addOption(
      'search',
      abbr: 's',
      help: 'Search clipboard history',
      valueHelp: 'query',
    )
    ..addOption('delete', abbr: 'd', help: 'Delete an item', valueHelp: 'index')
    // Flags
    ..addFlag('stats', help: 'Show statistics', negatable: false)
    ..addFlag(
      'clear',
      help: 'Clear all history (requires confirmation)',
      negatable: false,
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show this help message',
      negatable: false,
    )
    ..addFlag(
      'version',
      abbr: 'v',
      help: 'Show version information',
      negatable: false,
    );
}

void printUsage(ArgParser argParser) {
  print('Usage: clipflow <flags> [arguments]');
  print(argParser.usage);
}

Future<void> main(List<String> arguments) async {
  final ArgParser argParser = buildParser();

  try {
    final ArgResults results = argParser.parse(arguments);

    final storage = ClipflowStorage();
    final manager = ClipflowManager(storage);

    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }

    if (results.flag('version')) {
      final resolvedVersion = await manager.getAppVersion();
      print('$kAppName version: $resolvedVersion');
      return;
    }

    await storage.load();

    bool commandExecuted = false;

    // Capture
    if (results.flag('capture')) {
      print('📝 Enter text to capture (press Ctrl+D when done):');
      final content = await stdin.transform(utf8.decoder).join();
      if (content.trim().isEmpty) {
        print('❌ No text entered.');
      } else {
        manager.capture(content.trim());
        print('✅ Captured!');
      }
      commandExecuted = true;
    }

    // List
    if (results.wasParsed('list')) {
      final limit = int.tryParse(results.option('list')!) ?? kDefaultListLimit;
      manager.list(limit: limit);
      commandExecuted = true;
    }

    // View
    if (results.wasParsed('view')) {
      final index = int.tryParse(results.option('view')!);
      if (index == null) {
        print('❌ Invalid index. Must be a number.');
      } else {
        final item = manager.getItemAt(index);
        if (item != null) {
          item.displayFull();
        } else {
          throw InvalidIndexException(index, storage.items.length);
        }
      }
      commandExecuted = true;
    }

    // Search
    if (results.wasParsed('search')) {
      final query = results.option('search')!;
      final searchResults = manager.search(query);

      if (searchResults.isEmpty) {
        print('\n🔍 No results found for: "$query"');
        print('');
      } else {
        print('\n🔍 Found ${searchResults.length} result(s) for: "$query"');
        print('─' * 70);
        for (var i = 0; i < searchResults.length; i++) {
          print(searchResults[i].toListItem(i));
        }
        print('');
      }
      commandExecuted = true;
    }

    // Delete
    if (results.wasParsed('delete')) {
      final index = int.tryParse(results.option('delete')!);
      if (index == null) {
        print('❌ Invalid index. Must be a number.');
      } else {
        await manager.delete(index);
      }
      commandExecuted = true;
    }

    // Stats
    if (results.flag('stats')) {
      manager.showStats();
      commandExecuted = true;
    }

    // Clear
    if (results.flag('clear')) {
      stdout.write('⚠️  Clear all history? This cannot be undone! (y/n): ');
      final confirm = stdin.readLineSync();
      if (confirm?.toLowerCase() == 'y') {
        await storage.clear();
        print('🗑️  All history cleared!');
      } else {
        print('❌ Cancelled');
      }
      commandExecuted = true;
    }

    // If no command was executed, show help
    if (!commandExecuted) {
      printUsage(argParser);
    }
  } on FormatException catch (e) {
    print('\n❌ ${e.message}');
    print('');
    printUsage(argParser);
    exit(1);
  } on ClipflowException catch (e) {
    print('\n$e\n');
    exit(1);
  } catch (e) {
    print('\n❌ Unexpected error: $e\n');
    exit(1);
  }
}
