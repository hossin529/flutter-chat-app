import 'package:chat_app/ui/screens/login_screen.dart';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/screens/signup_screen.dart';
import 'package:chat_app/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

const String initialRoute = "welcome";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'main':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case 'welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'sign-up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
