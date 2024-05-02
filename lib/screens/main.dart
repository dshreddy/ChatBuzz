import 'package:chat/screens/friends.dart';
import 'package:chat/screens/profile.dart';
import 'package:chat/screens/requests.dart';
import 'package:chat/screens/servers.dart';
import 'package:chat/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});
  static String id = "main_screen";

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  int currentPageIndex = 0;
  List<Widget> items = [
    Servers(),
    Friends(),
    Requests(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Image(image: AssetImage("assets/images/favicon.png")),
          actions: [
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  //Implement logout functionality
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
          ],
          backgroundColor: Colors.orangeAccent,
        ),
        body: items[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.orangeAccent,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.white,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.groups),
              label: 'Groups',
            ),
            NavigationDestination(
              icon: Icon(Icons.forum),
              label: 'Chats',
            ),
            NavigationDestination(
              icon: Icon(Icons.group_add_outlined),
              label: 'Requests',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
