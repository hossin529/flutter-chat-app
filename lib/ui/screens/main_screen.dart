import 'dart:convert';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/users/profile_screen.dart';
import 'package:chat_app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

import 'conversations_screen.dart';

class MainScreen extends StatefulWidget {
  static final routeName = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  initState() {
    super.initState();

    _firebaseMessaging.getToken().then((token) {
      Provider.of<UserProvider>(context).setFcmToken(token);
    });
    notification();
  }

  notification() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        handleNotification(message['data'], false);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  handleNotification(data, bool push) {
    var messageJson = json.decode(data['message']);
    var message = MessageModal.fromJson(messageJson);
    Provider.of<ConversationProvider>(context)
        .addMessageToConversation(message.conversationId, message);
  }

  final PageController _pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          ConversationsScreen(),
          Container(
            color: Colors.green,
          ),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        backgroundColor: Style.darkColor,
        onTap: (i) {
          setState(() {
            currentIndex = i;
            _pageController.animateToPage(i,
                duration: kTabScrollDuration, curve: Curves.easeIn);
          });
        },
        // borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Style.primaryColor,
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              )),
          BubbleBottomBarItem(
              backgroundColor: Style.primaryColor,
              icon: Icon(
                Icons.people_outline,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.people_outline,
                color: Colors.white,
              ),
              title: Text(
                "Friends",
                style: TextStyle(color: Colors.white),
              )),
          BubbleBottomBarItem(
              backgroundColor: Style.primaryColor,
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
