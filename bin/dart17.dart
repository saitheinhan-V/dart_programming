//stream //chat room simulator
import 'dart:async';

class ChatRoom {
  // Private controller - only we can add messages
  final _messageController = StreamController<ChatMessage>();

  // Public stream - anyone can listen
  Stream<ChatMessage> get messages => _messageController.stream;

  // Send a message to the stream
  void sendMessage(String username, String text) {
    final message = ChatMessage(
      username: username,
      text: text,
      timestamp: DateTime.now(),
    );
    _messageController.sink.add(message);
  }

  // CRITICAL: Clean up resources
  void dispose() {
    _messageController.close();
  }
}

class ChatMessage {
  final String username;
  final String text;
  final DateTime timestamp;

  ChatMessage({
    required this.username,
    required this.text,
    required this.timestamp,
  });

  @override
  String toString() {
    final time =
        "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
    return "[$time] $username: $text";
  }
}

void main() async {
  print("💬 Chat Room Started\n");

  final chatRoom = ChatRoom();

  // Subscribe to messages
  final subscription = chatRoom.messages.listen((message) => print(message));

  // Simulate conversation
  chatRoom.sendMessage("Alice", "Hey everyone! 👋");
  await Future.delayed(Duration(seconds: 1));

  chatRoom.sendMessage("Bob", "Hi Alice! How's Flutter going?");
  await Future.delayed(Duration(seconds: 5));

  chatRoom.sendMessage("Alice", "Amazing! Just learned Streams today 🔥");
  await Future.delayed(Duration(seconds: 1));

  chatRoom.sendMessage("Charlie", "Streams are powerful! 💪");

  // Cleanup
  await Future.delayed(Duration(seconds: 1));
  print("\n👋 Chat Room Closing...");
  await subscription.cancel();
  chatRoom.dispose();
}
