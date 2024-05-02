import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../provider/main.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<String> friends = [];
  late String username;
  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = Provider.of<UserProvider>(context, listen: false).username;
    // Fetch servers from the API when the widget initializes
    _fetchFriends();
  }

  Future<void> _fetchFriends() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final response = await http.get(
        Uri.parse('${flaskserverURL}friends/$username'),
      );

      if (response.statusCode == 200) {
        // Assuming response.body contains JSON data like {'servers': ['server1', 'server2', ...]}
        dynamic responseData = jsonDecode(response.body);
        List<dynamic> dynamicServers =
            responseData['friends']; // List of dynamic objects
        // Convert dynamic objects to strings

        setState(() {
          friends = dynamicServers.map((server) => server.toString()).toList();
        });
      } else {
        alert("Error");
      }
    } catch (e) {
      alert("$e");
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              // You can use profile pictures here
              child: Text(friends[index][0]), // Display initials for simplicity
            ),
            title: Text(friends[index]),
            onTap: () {
              // Handle friend item tap
              // You can navigate to a chat screen or perform an action here
              Navigator.pushNamed(context, ChatScreen.id);
            },
          );
        },
      ),
    );
  }

  void alert(String desc) {
    Alert(
      style: const AlertStyle(
        backgroundColor: Colors.orangeAccent,
        descStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'Overpass',
          fontWeight: FontWeight.w700,
        ),
      ),
      context: context,
      desc: desc,
      buttons: [
        DialogButton(
            color: Colors.white,
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    ).show();
  }
}
