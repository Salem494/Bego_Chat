import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/onboarding_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  late String text;
  TextEditingController messageText = TextEditingController();
  late SharedPreferences prefs;
  String? email;

  Future<void> sendMessage() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');

    FirebaseFirestore.instance.collection("messages").add({
      'text': text,
      'sender': email,
      'time': FieldValue.serverTimestamp()
    }).then((value) {
      print("ID :${value.id}");
    }).catchError((e) {
      print("error : ${e}");
    });
  }

  Future<void> logout(context) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.remove('token').then((value) {
      if (value) {
        NavigateAndRemove(context: context, widget: OnBoardingScreen());
      }
    }).catchError((e) {
      print(" Error : ${e.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Message Hhhhhhhh !",
            style: textStyle(color: Colors.white, fontSize: 20.0)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            onTap: () {
              logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.fill)),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ListView.builder(
                      primary: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10.0, bottom: 18.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: email == messages[i]['sender']
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                      topRight:Radius.circular(20.0)
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Center(
                                  child: Text(messages[i]['text'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                ),
                              ),
                              Text(messages[i]['sender'] ?? '',
                                  style: textStyle(
                                      color: Colors.white, fontSize: 12.0)),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: messageText,
                      onChanged: (value) {
                        text = value;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          // fillColor: Colors.white,
                          filled: true,
                          hintText: 'Write Your Message Here ....',
                          hintStyle:
                              TextStyle(color: Colors.white54,
                                  fontSize: 20.0)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      messageText.clear();
                      sendMessage();
                    },
                    child: Text(
                      "Send",
                      style: textStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
