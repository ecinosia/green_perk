import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatTestPage extends StatefulWidget {
  const ChatTestPage({super.key});

  @override
  State<ChatTestPage> createState() => _ChatTestPageState();
}

class _ChatTestPageState extends State<ChatTestPage> {
  final gemini = Gemini.instance;
  final List<String> chatHistory = [];
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void sendMessage(String message) {
    chatHistory.add("User: $message");

    gemini.text(message).then((value) {
      setState(() {
        chatHistory.add("Gemini: ${value?.output}");
      });
    }).catchError((e) {
      setState(() {
        chatHistory.add("Error: ${e.toString()}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(chatHistory[index]),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    sendMessage(textController.text);
                    textController.clear();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
