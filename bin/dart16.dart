//stream - a sequence of asynchronous events that can be processed as they arrive
void main() async {
  print('🚀 Starting countdown at ${DateTime.now()}');

  Stream<int> countdown = Stream.periodic(
    const Duration(seconds: 1),
    (count) => 10 - count,
  ).take(11);

  final subscription = countdown.listen(
    (seconds) {
      if (seconds > 0) {
        print('⏲️ $seconds');
      } else {
        print('BLAST OFF!!!!');
      }
    },
    onError: (error) {
      print('Error $error');
    },
    onDone: () {
      print('✅ Countdown complete');
    },
  );

  await Future.delayed(const Duration(seconds: 12));

  await subscription.cancel();
}
