import 'package:flutter/material.dart';

class Custom_Form_Feild extends StatelessWidget {
  final String? label_text;
  final Icon? icon;
  final Widget? label_widget;
  final double o_border_radius;
  final Color bordersidecolor;
  final String? hint_text;
  final bool obscureText;
  final IconButton? suffixIcon;
  final TextEditingController? textEditingController;
  double height;
  double width;

  Custom_Form_Feild(
      {super.key,
      this.height = 55,
      this.width = 400,
      this.textEditingController,
      this.label_text,
      this.suffixIcon,
      this.hint_text,
      this.icon,
      this.label_widget,
      required this.o_border_radius,
      required this.obscureText,
      required this.bordersidecolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: textEditingController,
        obscureText: obscureText,
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hint_text,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: bordersidecolor,
              ),
              borderRadius: BorderRadius.circular(o_border_radius),
            ),
            labelText: label_text,
            label: label_widget,
            icon: icon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(o_border_radius))),
      ),
    );
  }
}
