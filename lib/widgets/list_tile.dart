import 'package:chat_app/essentials/constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  Widget? trailing;
  Widget? leading;
  Widget? title;
  Widget? subtitle;
  VoidCallback? onTap ;
  CustomListTile(
      {super.key,
      this.trailing,
      this.leading,
      this.subtitle,
      this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return 
      
      ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        trailing: trailing,
        leading: leading,
        iconColor: MyColors.kiconColor,
        title: title,
        subtitle: subtitle,
        tileColor: MyColors.klistTile,
        onTap: () {},
      
    );
  }
}
