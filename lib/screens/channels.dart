import 'package:chat/screens/chat.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/screens/main.dart';
import 'package:flutter/material.dart';

class Channels extends StatefulWidget {
  final String server;
  const Channels({super.key, required this.server});

  @override
  State<Channels> createState() => _ChannelsState();
}

class _ChannelsState extends State<Channels> {
  List<String> channels = [
    "General",
    "Announcements",
    "Discussion",
    "Off-Topic",
  ]; // Sample list of channels

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.server,
          style: TextStyle(color: Colors.white),
        ),
        leading: const Image(image: AssetImage("assets/images/favicon.png")),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: channels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(channels[index]),
            onTap: () {
              // Handle channel item tap if needed
              Navigator.pushNamed(context, ChatScreen.id);
            },
          );
        },
      ),
    );
  }
}
