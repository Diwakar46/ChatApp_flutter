import 'package:chat_app/chatpage/chat_page.dart';
import 'package:chat_app/home/home_page.dart';
import 'package:chat_app/login&register/auth_service.dart';
import 'package:chat_app/login&register/login.dart';
import 'package:chat_app/login&register/profile_pic_page.dart';
import 'package:chat_app/login&register/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: " AIzaSyBhFbqx03BUOsIuleTx8924HmqY_tcor0Q ",
          appId: "1:757421174736:android:d21b828b55adec117853d5",
          messagingSenderId: "757421174736 ",
          projectId: "thewalker-5a15c",storageBucket: "gs://thewalker-5a15c.appspot.com"),
          );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: GetMaterialApp(
        routes: {
          "/home": (context) => const HomePage(),
          "/login": (context) => LoginPage(),
          "/register": (context) => RegisterPage(),
          "/profile_pic_page": (context) => const ProfilePicPage(),
        },
        debugShowCheckedModeBanner: false,
        home:  LoginPage(),
      ),
    ),
  );
}
