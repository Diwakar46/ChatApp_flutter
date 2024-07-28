import 'dart:io';
import 'package:chat_app/chatpage/chat_page.dart';
import 'package:chat_app/essentials/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // final FirebaseAuth auth = Provider.of<AuthService>(context, listen: false);
    Widget buildUserListItem(DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;

      if (auth.currentUser!.email != data['email']) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: MyColors.klistTile,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(data['email']),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
            subtitle: Text(data['firstName'] + ' ' + data['lastName']),
            onTap: () {
              Get.to(ChatPage(
                  receiverUserId: data['uid'],
                  receiverUserEmail: data['email']));
            },
          ),
        );
      } else {
        return SafeArea(child: Container());
      }
    }

    Widget buildUserList() {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('ChatUsers')
              .snapshots(), //Accessing data that we have store in cloud
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return ListView(
              children: snapshot.data!.docs
                  .map<Widget>((doc) => buildUserListItem(doc))
                  .toList(),
            );
          });
    }

    Widget uploadImageWidget(File? image) {
      return IconButton(
          onPressed: () {},
          icon: (image != null)
              ? Image.file(image)
              : IconButton(
                  onPressed: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                  },
                  icon: const Icon(Icons.add_a_photo)));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Get.toNamed('/login');
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: buildUserList(),
    );
  }
}
