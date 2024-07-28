import 'package:chat_app/home/home_page.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> homeRoute = <String, WidgetBuilder>{
    "/home": (context) =>  const HomePage()
  };
}
