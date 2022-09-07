import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   late Widget widget;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

   Token = prefs.getString('token');
   print("Token :${Token}");

  if(Token != null){
    widget = HomeScreen();
  }else {
    widget = OnBoardingScreen();
  }
  runApp( MyApp(startWidget:widget,));
}

class MyApp extends StatelessWidget {
  late Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chats',
      debugShowCheckedModeBanner: false,
      theme:themeData,
      darkTheme: darkTheme,
      home:startWidget,
    );
  }
}

