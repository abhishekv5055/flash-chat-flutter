import 'package:flutter/material.dart';

final TextStyle kTitleStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w600,
);

final TextStyle kBaseHeadingTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
);

final InputDecoration kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  ),
  hintText: 'Write your message',
  hintStyle: TextStyle(
    color: Colors.black54,
  ),
  border: InputBorder.none,
);
