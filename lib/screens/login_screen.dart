import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> onClick(context) async {
    if (formKey.currentState!.validate()) {
     await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text, password: password.text)
          .then((value) {
        print("Email : ${value.user!.email}");
        NavigateAndRemove(context: context, widget: HomeScreen());
      }).catchError((error) {
        print("Error : ${error.toString()}");
      });
    }else{
      print(" SomeThings Have Error !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/chat.png",
              fit: BoxFit.cover, height: 120, width: 120),
          SizedBox(
            height: 15.0,
          ),
          Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: textFormField(
                        color: Colors.black,
                        fillColor: Colors.grey.shade200,
                        hintText: "Email ",
                        icon: Icons.email,
                        onChanged: (value) {},
                        controller: email,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "please enter your email !";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: textFormField(
                        color: Colors.white,
                        fillColor: Colors.grey.shade200,
                        hintText: "Password ",
                        icon: Icons.password,
                        onChanged: (value) {},
                        controller: password,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "please enter your password !";
                          } else {
                            return null;
                          }
                        }),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: customButton(
                        title: 'Login ',
                        onPressed: (){
                          onClick(context);
                        },
                        color: Colors.teal.shade400,
                        Textcolor: Colors.white,
                        height: 50,
                        width: 250),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
