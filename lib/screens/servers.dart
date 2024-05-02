import 'dart:convert';
import 'package:chat/constants.dart';
import 'package:chat/screens/channels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../provider/main.dart';

class Servers extends StatefulWidget {
  const Servers({Key? key}) : super(key: key);

  @override
  State<Servers> createState() => _ServersState();
}

class _ServersState extends State<Servers> {
  late String username;
  bool showSpinner = false;
  List<String> servers = []; // Sample server list

  @override
  void initState() {
    super.initState();
    username = Provider.of<UserProvider>(context, listen: false).username;
    // Fetch servers from the API when the widget initializes
    _fetchServers();
  }

  Future<void> _fetchServers() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final response = await http.post(
        Uri.parse('${flaskserverURL}servers'),
        body: {
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        // Assuming response.body contains JSON data like {'servers': ['server1', 'server2', ...]}
        dynamic responseData = jsonDecode(response.body);
        List<dynamic> dynamicServers =
            responseData['servers']; // List of dynamic objects
        // Convert dynamic objects to strings

        setState(() {
          servers = dynamicServers.map((server) => server.toString()).toList();
        });
      } else {
        alert("Error");
      }
    } catch (e) {
      print(e);
      alert("$e");
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView.builder(
          itemCount: servers.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.computer),
              title: Text(servers[index]),
              onTap: () {
                // Handle server item tap
                // You can navigate to another screen or perform an action here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Channels(server: servers[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          _showCreateServerDialog();
        },
        tooltip: 'Create Server',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showCreateServerDialog() {
    TextEditingController serverNameController = TextEditingController();
    TextEditingController serverDescriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Server'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: serverNameController,
                decoration: InputDecoration(labelText: 'Server Name'),
              ),
              TextField(
                controller: serverDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String serverName = serverNameController.text;
                String serverDescription = serverDescriptionController.text;

                // Process create server logic here
                _createServer(serverName, serverDescription);

                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _createServer(String serverName, String serverDescription) {
    // Implement logic to create server
    print('Creating server: $serverName, Description: $serverDescription');
    // Add logic to add the new server to your data or perform API call
    // For demonstration purposes, let's add it to the list directly
    setState(() {
      servers.add(serverName);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up controllers if needed
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
