import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBOT extends StatefulWidget {
  @override
  State<ChatBOT> createState() => _ChatBOTState();
}

class _ChatBOTState extends State<ChatBOT> {
  final TextEditingController _textController = TextEditingController();

  // Initialize the _messages list with a default bot message
  final List<Map<String, String>> _messages = [
    {
      'sender': 'bot',
      'text':
          'Hi there, Farmer! 🌾 I’m here to help with crops, fertilizers, pests, and more. How can I assist you today?'
    }
  ];

  void geminiOutput() async {
    if (_textController.text.isEmpty) {
      return;
    }

    String userInput = _textController.text;
    setState(() {
      _messages.add({'sender': 'user', 'text': userInput});
      _textController.clear(); // Clear the text field after user input
    });

    // Generative AI model setup with a concise answer prompt
    String prompt = "Provide a short and to-the-point answer: $userInput";
    final content = [Content.text(prompt)];
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyD-QOD7OMLF96oJ32ahG1GXLT-RdRTZfjo",
    );

    try {
      final response = await model.generateContent(content);
      setState(() {
        String botResponse = response.text ?? "No response";
        // Remove asterisks from the bot response
        botResponse = botResponse.replaceAll('*', '');
        _messages.add({'sender': 'bot', 'text': botResponse});
      });
    } catch (e) {
      setState(() {
        _messages
            .add({'sender': 'bot', 'text': 'Error: Unable to fetch response.'});
      });
    }
  }

  Widget _buildMessageItem(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isUser ? Colors.greenAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message['text']!,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E9E9),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(59, 180, 118, 1),
        title: Text(
          "Chatbot",
          style: TextStyle(
            fontFamily: "Coolvetica",
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(_messages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Enter your message...",
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) =>
                          geminiOutput(), // Trigger on Enter key
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: geminiOutput,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
