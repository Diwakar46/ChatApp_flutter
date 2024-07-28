import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String button_text;
  final Color button_color;
  final Color text_color;
  final VoidCallback onpressed;
  const MyButton(
      {super.key,
      required this.onpressed,
      required this.button_text,
      required this.button_color,
      required this.text_color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            // minimumSize: WidgetStateProperty.all(Size(100, 200)), --> Size of the button
            backgroundColor: WidgetStateProperty.all(button_color),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
        onPressed: onpressed,
        child: Text(
          button_text,
          style: TextStyle(color: text_color),
        ));
  }
}
