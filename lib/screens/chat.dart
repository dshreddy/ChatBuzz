import 'package:chat/widgets/message_box.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'login.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static String id = "chat_screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  bool showSpinner = false;
  String? typedMessage;
  List<Widget> messages = [
    const MessageBox(sender: "user1", text: "Hello", isMe: true),
    const MessageBox(sender: "user2", text: "Hello", isMe: false),
  ];

  @override
  void initState() {
    super.initState();
    //TODO: Implement fetch messages functionality
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Image(image: AssetImage("assets/images/favicon.png")),
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                Navigator.pop(context);
              }),
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: messages,
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        typedMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO: Implement send message functionality.
                      setState(() {
                        messages.add(MessageBox(
                            sender: "dshr", text: typedMessage!, isMe: false));
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
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
