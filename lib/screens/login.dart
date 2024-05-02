import 'dart:convert';
import 'package:chat/screens/main.dart';
import 'package:chat/screens/signup.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../provider/main.dart';
import '../widgets/custom_button.dart';
import 'forgot_password.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username;
  String? password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),

                // Logo
                const Flexible(
                  child: Image(
                    height: logoHeight,
                    image: AssetImage("assets/images/favicon.png"),
                  ),
                ),
                const SizedBox(height: gap),

                // Email
                Flexible(
                  child: SizedBox(
                    width: fieldSize,
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: 5,
                      color: Colors.white,
                      child: TextField(
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: "Username"),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          username = value;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: gap),

                //Password
                Flexible(
                  child: SizedBox(
                    width: fieldSize,
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: 5,
                      color: Colors.white,
                      child: TextField(
                        obscureText: true,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: "Password"),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                  ),
                ),

                // Login button
                CustomButton(
                  buttonText: 'Login',
                  onPressed: () async {
                    if (username == null || password == null) {
                      alert("FIELD IS NULL");
                      return;
                    }
                    setState(() {
                      showSpinner = true;
                    });
                    Provider.of<UserProvider>(context, listen: false)
                        .setUsername(username!);
                    Provider.of<UserProvider>(context, listen: false)
                        .setPassword(password!);
                    // TODO 1:Handle login
                    Navigator.pushNamed(context, AppBody.id);
                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),

                //Don't have an account text
                Flexible(
                  child: Row(
                    children: <Widget>[
                      const Expanded(child: SizedBox()),
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            decorationThickness: 0.5,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),

                // Forgot password text
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordScreen.id);
                  },
                  child: const Text(
                    "Forgot my password",
                    style: TextStyle(
                      color: Colors.grey,
                      decorationThickness: 0.8,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleLogin() async {
    setState(() {
      showSpinner = true;
    });

    final response = await http.post(
      Uri.parse('$flaskserverURL/login'),
      body: {
        'username': username!,
        'password': password!,
      },
    );

    if (response.statusCode == 200) {
      // Login successful, navigate to the next screen
      Navigator.pushNamed(context, AppBody.id);
    } else {
      // Login failed, show an error message
      final error = jsonDecode(response.body)['error'];
      alert(error);
    }

    setState(() {
      showSpinner = false;
    });
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
