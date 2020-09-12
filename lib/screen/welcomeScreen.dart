import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/component/roundedButton.dart';
import 'package:flash_chat/screen/registrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 200.0,
              ),
            ),
            TypewriterAnimatedTextKit(
              speed: Duration(seconds: 1),
              text: ['Flash Chat'],
              textStyle: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                colors: Color(0xFF6747cd),
                buttonText: 'Getting Started',
              ),
            )
          ],
        ),
      ),
    );
  }
}
