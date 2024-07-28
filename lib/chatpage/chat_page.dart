import 'package:chat_app/chatpage/chatservices/chatservice.dart';
import 'package:chat_app/widgets/message_widget.dart';
import 'package:chat_app/widgets/text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animate_do/animate_do.dart';

class ChatPage extends StatelessWidget {
  ChatPage(
      {super.key,
      required this.receiverUserId,
      required this.receiverUserEmail});
  final String receiverUserId;
  final String receiverUserEmail;
  final TextEditingController _messagecontroller = TextEditingController();
  final Chatservice _chatservice = Chatservice();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatservice.sendMessage(receiverUserId, _messagecontroller.text);
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget messageItem(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
          ? Alignment.centerRight
          : Alignment.centerLeft;
      return Container(
        padding: const EdgeInsets.all(8),
        alignment: alignment,
        child: Column(children: [
          MessageWidget(text1: data['senderEmail'], text2: data['message'])
        ]),
      );
    }

    Widget messageList() {
      return StreamBuilder(
          stream: _chatservice.getMessages(
              receiverUserId, _firebaseAuth.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return ListView(
              children: snapshot.data!.docs
                  .map((document) => messageItem(document))
                  .toList(),
            );
          });
    }

    Widget messageInput() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Custom_Form_Feild(
              o_border_radius: 10,
              obscureText: false,
              bordersidecolor: Colors.black,
              textEditingController: _messagecontroller,
              hint_text: 'Enter Messages',
            )),
            IconButton(
                hoverColor: Colors.amber,
                highlightColor: Colors.black,
                color: Colors.black,
                onPressed: () {
                  sendMessage();
                },
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.black,
                ))
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton.outlined(
              onPressed: () {
                Get.toNamed('/home');
              },
              icon: const Icon(Icons.arrow_back))),
      body: Column(
        children: [
          Expanded(
            child: FadeInUp(
                duration: const Duration(seconds: 1), child: messageList()),
          ),
          messageInput(),
        ],
      ),
    );
  }
}
