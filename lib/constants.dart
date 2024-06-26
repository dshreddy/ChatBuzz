import 'package:flutter/material.dart';

const String flaskserverURL = "http://127.0.0.1:5000/";
const double logoHeight = 100;
const double fieldSize = 300;
const Color buttonColor = Colors.orangeAccent;
const double gap = 20;

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.orangeAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.grey),
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.orangeAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Text Field Decoration',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: buttonColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: buttonColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
