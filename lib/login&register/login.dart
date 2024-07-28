import 'package:chat_app/login&register/auth_service.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  RxBool eye_icon = false.obs;
  RxBool obscure_password = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService auth = AuthService();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Custom_Form_Feild(
              textEditingController: emailController,
              o_border_radius: 10,
              obscureText: false,
              bordersidecolor: Colors.black,
              hint_text: 'Enter your Email',
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Custom_Form_Feild(
                  textEditingController: passwordController,
                  o_border_radius: 10,
                  obscureText: obscure_password.value,
                  bordersidecolor: Colors.black,
                  suffixIcon: IconButton(
                      onPressed: () {
                        eye_icon.toggle();
                        obscure_password.toggle();
                      },
                      icon: Obx(() => Icon(eye_icon.value
                          ? Icons.visibility
                          : Icons.visibility_off))),
                  hint_text: 'Enter your Password',
                )),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              text_color: Colors.white,
              button_color: Colors.black,
              button_text: 'login',
              onpressed: () async {
                final message = await auth.login(
                    email: emailController.text,
                    password: passwordController.text);
              },
            ),
            TextButton(
                onPressed: () {
                 Navigator.pushNamed(context,'/register');
                },
                child: const Text(
                  "Register a new account?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
