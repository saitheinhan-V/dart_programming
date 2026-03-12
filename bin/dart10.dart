sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Failure<T> extends Result<T> {
  final String error;

  Failure(this.error);
}

Result<int> divide(int a, int b) {
  if (b == 0) {
    return Failure('Cannot divide by zero');
  }
  return Success(a ~/ b);
}

Result<int> parseNumber(String text) {
  try {
    final number = int.parse(text);
    return Success(number);
  } catch (e) {
    return Failure('Invalid number: $text');
  }
}

void main() {
  final result1 = divide(10, 2);
  final message1 = switch (result1) {
    Success(data: var value) => 'Result: $value',
    Failure(error: var msg) => 'Error: $msg',
  };
  print(message1);

  final result2 = divide(10, 0);
  final message2 = switch (result2) {
    Success(data: var value) => 'Result: $value',
    Failure(error: var msg) => 'Error: $msg',
  };
  print(message2);

  final result3 = parseNumber('42');
  print(switch (result3) {
    Success(data: var n) => 'Parsed: $n',
    Failure(error: var e) => 'Failed: $e',
  });

  final result4 = parseNumber('abc');
  print(switch (result4) {
    Success(data: var n) => 'Parsed: $n',
    Failure(error: var e) => 'Failed: $e',
  });
}
