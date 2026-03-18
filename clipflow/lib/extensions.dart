import 'package:clipflow/enums.dart';

extension DateTimeExtension on DateTime {
  String toReadable() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[month - 1]} $day, $year'
        '${hour.toString().padLeft(2, '0')}'
        '${minute.toString().padLeft(2, '0')}';
  }

  String timeAgo() {
    final diff = DateTime.now().difference(this);

    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }
}

extension StringExtension on String {
  bool get isURL {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && {'http', 'https'}.contains(uri.scheme);
    } catch (e) {
      return false;
    }
  }

  bool get isCode {
    final patterns = [
      'function ',
      'const ',
      'var ',
      'let ',
      'class ',
      'import ',
      'def ',
      'void ',
      '=> ',
      'public ',
      'private ',
      'final ',
      'String ',
      'int ',
    ];

    final matchCount = patterns.where((pattern) => contains(pattern)).length;

    return matchCount >= (patterns.length * 0.1);
  }

  bool get isJSON {
    final trimmed = trim();
    if (trimmed.isEmpty) return false;

    return (trimmed.startsWith('{') && trimmed.endsWith('}')) ||
        (trimmed.startsWith('[') && trimmed.endsWith(']'));
  }

  String truncate(int maxLength) {
    if (maxLength <= 0) return '';
    final singleLine = replaceAll(RegExp(r'\s+'), ' ').trim();

    if (singleLine.length <= maxLength) {
      return singleLine;
    }

    final cutoff = maxLength > 3 ? maxLength - 3 : 0;
    return '${singleLine.substring(0, cutoff)}...';
  }

  String get preview => truncate(70);

  ClipType detectType() {
    if (isURL) {
      return ClipType.urlType;
    } else if (isCode) {
      return ClipType.codeType;
    } else if (isJSON) {
      return ClipType.jsonType;
    }
    return ClipType.textType;
  }
}
