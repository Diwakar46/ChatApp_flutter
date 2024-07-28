import 'package:chat_app/essentials/constants.dart';
import 'package:chat_app/login&register/auth_service.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final RxBool eye_icon = false.obs;
  final RxBool obscure_password = true.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirm_passwordController =
      TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  AuthService auth = AuthService();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Custom_Form_Feild(
                      label_widget: Row(
                        children: [
                          const Text('First Name'),
                          Text(
                            '*',
                            style: TextStyle(color: MyColors.kred),
                          )
                        ],
                      ),
                      width: 180,
                      textEditingController: firstNameController,
                      o_border_radius: 10,
                      obscureText: false,
                      bordersidecolor: Colors.black,
                      hint_text: 'Enter First Name',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Custom_Form_Feild(
                      label_widget: Row(
                        children: [
                          const Text('Last Name'),
                          Text(
                            '*',
                            style: TextStyle(color: MyColors.kred),
                          )
                        ],
                      ),
                      width: 180,
                      textEditingController: lastNameController,
                      o_border_radius: 10,
                      obscureText: false,
                      bordersidecolor: Colors.black,
                      hint_text: 'Enter Last Name',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Form_Feild(
                  label_text: 'Nick Name (Optional)',
                  textEditingController: nickNameController,
                  o_border_radius: 10,
                  obscureText: false,
                  bordersidecolor: Colors.black,
                  hint_text: 'Enter Nick Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Form_Feild(
                  label_widget: Row(
                    children: [
                      const Text('Email'),
                      Text(
                        '*',
                        style: TextStyle(color: MyColors.kred),
                      )
                    ],
                  ),
                  textEditingController: emailController,
                  o_border_radius: 10,
                  obscureText: false,
                  bordersidecolor: Colors.black,
                  hint_text: 'Create your Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => Custom_Form_Feild(
                      label_widget: Row(
                        children: [
                          const Text('Create Password'),
                          Text(
                            '*',
                            style: TextStyle(color: MyColors.kred),
                          )
                        ],
                      ),
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
                Obx(() => Custom_Form_Feild(
                      label_widget: Row(
                        children: [
                          const Text('Confirm Password'),
                          Text(
                            '*',
                            style: TextStyle(color: MyColors.kred),
                          )
                        ],
                      ),
                      textEditingController: confirm_passwordController,
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
                      hint_text: 'Confirm your Password',
                    )),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  text_color: Colors.white,
                  button_color: Colors.black,
                  button_text: 'Register',
                  onpressed: () async {
                    if (passwordController.text ==
                            confirm_passwordController.text &&
                        firstNameController.text.isNotEmpty &&
                        lastNameController.text.isNotEmpty) {
                      final message = await auth.registration(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          nickName: nickNameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                    } else if (firstNameController.text.isEmpty &&
                        lastNameController.text.isEmpty) {
                      Get.snackbar(
                          'Error', 'FirstName and LastName cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,backgroundColor: MyColors.kred);
                    } else {
                      throw Exception("Please enter correct passoword");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
