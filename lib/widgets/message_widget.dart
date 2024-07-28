// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  String text1;
  String text2;
  MessageWidget({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color:Colors.grey.withOpacity(0.1) ,borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(10),
      height: size.height*0.15,
      width: size.width*0.45,
      
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              text1,
              style: const TextStyle(decoration: TextDecoration.underline),
            ),
            Text(text2)
          ],
        ),
      ),
    );
  }
}
