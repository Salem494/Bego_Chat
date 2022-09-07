import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding:  EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/tt.jpg'),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Message Me",
                    style: textStyle(color: Colors.teal, fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: customButton(
                        title: "Log In ",
                        onPressed: () {
                          NavigateTo(context: context,
                              widget: LoginScreen());
                        },
                        color: Colors.deepPurple.shade100,
                        height: 50,
                        width: double.infinity,
                        Textcolor: Colors.black,
                        fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: customButton(
                        title: "Register ",
                        onPressed: () {
                          NavigateTo(context: context,
                              widget: RegisterScreen());
                        },
                        color: Colors.cyanAccent,
                        height: 50,
                        width: double.infinity,
                        Textcolor: Colors.black,
                        fontSize: 25),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
