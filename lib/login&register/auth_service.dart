import 'package:chat_app/essentials/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService extends ChangeNotifier {
  //instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  File? _image;
  File? get image => _image;
  //PickImage from gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
      await uploadImageToFirebase(_image!);
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageRef.putFile(image);

    await uploadTask.whenComplete(() async {
      String imageUrl = await storageRef.getDownloadURL();
      await _saveImageUrlToFirestore(imageUrl);
    });
    notifyListeners();
  }

  Future<void> _saveImageUrlToFirestore(String url) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await _firebaseFirestore.collection('ChatUserImages').doc(user.uid).set(
          {'userImage': url},
          SetOptions(merge: true),
        );
        Get.snackbar('Sucess', 'Image Uploaded',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: MyColors.kred);
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload image',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: MyColors.kred);
      }
    }
  }

  //login
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed("/profile_pic_page");
      //Storing User uid and email in fireStore Database after logining in

      await _firebaseFirestore
          .collection('ChatUsers')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email},
              SetOptions(merge: true));
      //SetOptions helps not to create a new id

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//register
  Future<UserCredential> registration(
      {required String email,
      required String password,
      required firstName,
      required lastName,
      String nickName = ''}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // final UserCredential userCredentials = await _firebaseAuth
      Get.toNamed('/profile_pic_page');
      //taking userCrediential for saving pp_pic in uId

      await _firebaseFirestore
          .collection('ChatUsers')
          .doc(userCredential.user!.uid)
          .set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'nickName': nickName
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
