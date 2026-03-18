class ClipflowException implements Exception {
  final String message;

  ClipflowException(this.message);

  @override
  String toString() {
    return '❗ Clipflow Error: $message';
  }
}

class InvalidIndexException extends ClipflowException {
  final int providedIndex;
  final int length;

  InvalidIndexException(this.providedIndex, this.length)
    : super('Invalid index: $providedIndex, Valid range: 0-${length - 1}');
}

class ItemNotFoundException extends ClipflowException {
  ItemNotFoundException(String id) : super('Item not found $id');
}
