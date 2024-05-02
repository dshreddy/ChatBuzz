import 'package:flutter/material.dart';

enum RequestType {
  ServerJoinIncoming,
  ServerJoinOutgoing,
  FriendIncoming,
  FriendOutgoing,
}

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  List<RequestData> requests = [
    RequestData(RequestType.ServerJoinIncoming, "Server1", "John Doe"),
    RequestData(RequestType.ServerJoinOutgoing, "Server2", ""),
    RequestData(RequestType.FriendIncoming, "", "Alice"),
    RequestData(RequestType.FriendOutgoing, "", "Hello"),
  ]; // Sample list of requests

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: _getLeadingIcon(requests[index].type),
            title: Text(_getRequestTitle(requests[index])),
            subtitle: Text(_getRequestSubtitle(requests[index])),
            trailing: _getTrailingButton(requests[index].type),
            onTap: () {
              // Handle request item tap if needed
              print("Tapped request: ${requests[index]}");
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          _showRequestDialog(); // Show request dialog
        },
        tooltip: 'Send Request',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Request Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close request dialog
                  _showFriendRequestDialog(); // Show friend request dialog
                },
                child: Text('Friend Request'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close request dialog
                  _showServerJoinRequestDialog(); // Show server join request dialog
                },
                child: Text('Server Join Request'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFriendRequestDialog() {
    TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Friend Request'),
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Enter Username'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close friend request dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                // Process send friend request logic here
                _sendFriendRequest(username);
                Navigator.of(context).pop(); // Close friend request dialog
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showServerJoinRequestDialog() {
    TextEditingController serverIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Server Join Request'),
          content: TextField(
            controller: serverIdController,
            decoration: InputDecoration(labelText: 'Enter Server ID'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close server join request dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String serverId = serverIdController.text;
                // Process send server join request logic here
                _sendServerJoinRequest(serverId);
                Navigator.of(context).pop(); // Close server join request dialog
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _sendFriendRequest(String username) {
    // Implement logic to send friend request
    print('Sending friend request to $username');
  }

  void _sendServerJoinRequest(String serverId) {
    // Implement logic to send server join request
    print('Sending server join request for Server ID: $serverId');
  }

  Widget _getLeadingIcon(RequestType type) {
    switch (type) {
      case RequestType.ServerJoinIncoming:
      case RequestType.ServerJoinOutgoing:
        return Icon(Icons.group);
      case RequestType.FriendIncoming:
      case RequestType.FriendOutgoing:
        return Icon(Icons.person);
    }
  }

  String _getRequestTitle(RequestData request) {
    switch (request.type) {
      case RequestType.ServerJoinIncoming:
      case RequestType.ServerJoinOutgoing:
        return "Server Join Request";
      case RequestType.FriendIncoming:
      case RequestType.FriendOutgoing:
        return "Friend Request";
    }
  }

  String _getRequestSubtitle(RequestData request) {
    switch (request.type) {
      case RequestType.ServerJoinIncoming:
        return "From: ${request.userName} (Server: ${request.serverId})";
      case RequestType.ServerJoinOutgoing:
        return "To: ${request.serverId}";
      case RequestType.FriendIncoming:
        return "From: ${request.userName}";
      case RequestType.FriendOutgoing:
        return "To: ${request.userName}";
    }
  }

  Widget _getTrailingButton(RequestType type) {
    switch (type) {
      case RequestType.ServerJoinIncoming:
      case RequestType.FriendIncoming:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Handle accept action
                print("Accepted request");
              },
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // Handle reject action
                print("Rejected request");
              },
            ),
          ],
        );
      case RequestType.ServerJoinOutgoing:
      case RequestType.FriendOutgoing:
        return const Text("Pending");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class RequestData {
  final RequestType type;
  final String serverId;
  final String userName;

  RequestData(this.type, this.serverId, this.userName);
}
