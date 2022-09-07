
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  createUser(context) async {
    print("Enter");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     if(formKey.currentState!.validate()){
       print("valede");
          FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text,
              password: password.text).then((value) {
                prefs.setString('email', value.user!.email.toString());
                prefs.setString('token', value.user!.uid).then((value){
                  NavigateAndRemove(context: context, widget: HomeScreen());
                });
          }).catchError((e){
                print("Error : ${e.toString()}");
          });
          print("create !");
     }else {
       print("DaaaaaaF !");
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
                        hintText: "Name ",
                        icon: Icons.person,
                        onChanged: (value) {},
                        controller: name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "please enter your name !";
                          } else {
                            return null;
                          }
                        }),
                  ),
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
                  customButton(
                      title: 'Register',
                      onPressed: () {
                        print("Emmmmmmmmmmmmmy");
                        createUser(context);
                      },
                      color: Colors.teal.shade400,
                      Textcolor: Colors.white,
                      height: 50,
                      width: 250),
                ],
              ))
        ],
      ),
    );
  }
}
