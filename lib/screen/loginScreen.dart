import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/component/inputTextField.dart';
import 'package:flash_chat/component/roundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screen/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  height: 120.0,
                ),
              ),
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: kTitleStyle,
              ),
              Text(
                'Sign in to continue',
                textAlign: TextAlign.center,
                style: kBaseHeadingTextStyle,
              ),
              SizedBox(
                height: 50.0,
              ),
              InputTextField(
                hintText: 'Enter your Email',
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 32.0,
              ),
              InputTextField(
                hintText: 'Enter your Password',
                labelText: 'Password',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 32.0,
              ),
              RoundedButton(
                buttonText: 'Sign in',
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    spinner = false;
                  });
                },
                colors: Color(0xFF6747cd),
              ),
              SizedBox(
                height: 32.0,
              ),
              Material(
                color: Colors.white,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'New to Flash Chat ? Sign Up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
