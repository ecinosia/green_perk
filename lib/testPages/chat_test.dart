import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatTestPage extends StatefulWidget {
  const ChatTestPage({super.key});

  @override
  State<ChatTestPage> createState() => _ChatTestPageState();
}

class _ChatTestPageState extends State<ChatTestPage> {
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: "AIzaSyDDOY0xzyK41CR5XN9K3zapzIDKcsAm7Nc");
  bool loading = false;
  final List<String> chatHistory = [];
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    model;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void sendMessage(String message) async {
    setState(() {
      loading = true;
      textController.clear();
    });

    chatHistory.add("User: $message");
    final prompt = message;
    final content = [Content.text(prompt)];

    try {
      final response = await model.generateContent(content);
      setState(() {
        chatHistory.add("Gemini: ${response.text}");
        loading = false;
      });
    } catch (e) {
      setState(() {
        chatHistory.add("Error: ${e.toString()}");
        loading = false;
      });
    }
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
                  child: loading
                      ? const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: Colors.black,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
