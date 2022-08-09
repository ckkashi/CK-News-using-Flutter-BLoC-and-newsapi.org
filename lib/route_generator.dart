import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/error_page.dart';
import 'package:news_app/screens/home.dart';
import 'package:news_app/screens/splash.dart';
import 'package:news_app/services/connectivity/connectivityScreen.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/connectivity':
        return MaterialPageRoute(builder: (_) => ConnectivityScreen());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage('Page not found'));
    }
  }
}
