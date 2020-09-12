import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/component/inputTextField.dart';
import 'package:flash_chat/component/roundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screen/chatScreen.dart';
import 'package:flash_chat/screen/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              Container(
                child: Image.asset('images/logo.png'),
                height: 120.0,
              ),
              Text(
                'Welcome to Flash Chat',
                textAlign: TextAlign.center,
                style: kTitleStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Sign up to continue',
                textAlign: TextAlign.center,
                style: kBaseHeadingTextStyle,
              ),
              SizedBox(
                height: 50.0,
              ),
              InputTextField(
                hintText: 'Enter your Email',
                labelText: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
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
                buttonText: 'Sign up',
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
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
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    'Already have an account ? Sign In',
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
