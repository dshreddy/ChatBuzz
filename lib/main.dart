import 'package:chat/provider/main.dart';
import 'package:chat/screens/forgot_password.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/screens/main.dart';
import 'package:chat/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'buzz',
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        // Define other theme properties here
      ),
      initialRoute: LoginScreen.id,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
        AppBody.id: (context) => AppBody(),
      },
    );
  }
}
