import 'package:auth_client/widgets/user/user_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    // print(userInfo['username']);
    // username = userInfo['username'];
    // imageUrl = userInfo['image_url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text('로그인 완료')),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: fetchUserInfo(),
              builder: (ctx, ss) {
                if (ss.connectionState == ConnectionState.done) {
                  var username = ss.data!['username'];
                  var imageUrl = ss.data!['image_url'];
                  return Center(
                    child: Column(
                      children: [
                        UserImage(image: NetworkImage(imageUrl)),
                        Text(_firebaseAuth.currentUser!.email!),
                        Text(username),
                      ],
                    ),
                  );
                } else if (ss.hasError) {
                  throw ss.error!;
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                _firebaseAuth.signOut();
              },
              child: const Text('로그아웃'),
            ),
          ),
        ],
      ),
    );
  }
}
