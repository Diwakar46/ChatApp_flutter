import 'package:chat_app/login&register/auth_service.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePicPage extends StatelessWidget {
  const ProfilePicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: GestureDetector(
            child: (authservice.image == null)
                ? Image.asset('assets/images/add_pp_placeholder.jpg')
                : CircleAvatar(
                    backgroundImage: FileImage(authservice.image!),
                    radius: 70,
                  ),
            onTap: () {
              authservice.pickImage();
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MyButton(
            onpressed: () {
              authservice.pickImage();
            },
            button_text: 'Upload Profile Image',
            button_color: Colors.black,
            text_color: Colors.white),
        const SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyButton(
                onpressed: () {
                  Get.toNamed('/home');
                },
                button_text: 'Skip',
                button_color: Colors.black,
                text_color: Colors.white),
            MyButton(
                onpressed: ()  async{
                 await  authservice.uploadImageToFirebase(authservice.image!);
                  Get.toNamed('/home');
                },
                button_text: 'Done',
                button_color: Colors.black,
                text_color: Colors.white)
          ],
        )
      ],
    ));
  }
}
