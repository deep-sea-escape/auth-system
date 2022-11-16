import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signIn();
  Future<UserCredential> signUp();
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  Future<void> updateUserImage(UserCredential userCredential);
  Map<String, dynamic> getUserInfo(UserCredential userCredential);

  Future<void> registerUser() async {
    final UserCredential userCredential = await signUp();
    if (userCredential.additionalUserInfo!.isNewUser) {
      final User user = userCredential.user!;
      final String uid = user.uid;
      await updateUserImage(userCredential);
      await updateUserInfo(
        uid,
        getUserInfo(userCredential),
      );
    }
  }

  Future<String?> uploadUserImage(String uid, XFile? image) async {
    if (image != null) {
      // save image file to the storage
      final ref =
          FirebaseStorage.instance.ref().child('user_images').child('$uid.jpg');
      if (kIsWeb) {
        await ref.putData(await image.readAsBytes()).then(
          (p0) {
            print(p0);
          },
        );
      } else {
        await ref.putFile(File(image.path)).then(
          (p0) {
            print(p0);
          },
        );
      }
      return ref.getDownloadURL();
    } else {
      return null;
    }
  }

  Future<void> updateUserInfo(String uid, Map<String, dynamic> userInfo) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(userInfo);
  }
}
