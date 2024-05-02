import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/main.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email: user@example.com", // Replace with actual user email
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Username:${Provider.of<UserProvider>(context, listen: false).username}", // Replace with actual username
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Change Password",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Old Password',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orangeAccent),
              ),
              onPressed: () {
                // Handle change password button press
                _handleChangePassword();
              },
              child: const Text(
                "Change Password",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleChangePassword() {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;

    // Validate input (e.g., check if fields are not empty)

    // Call backend function to change password
    // Example:
    // backendService.changePassword(oldPassword, newPassword)
    //     .then((response) {
    //   // Handle success or error response
    // }).catchError((error) {
    //   // Handle error
    // });

    // Reset text fields after processing
    _oldPasswordController.clear();
    _newPasswordController.clear();
  }

  @override
  void dispose() {
    // Clean up text controllers
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
