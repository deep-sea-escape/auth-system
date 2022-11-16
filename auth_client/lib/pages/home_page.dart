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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .snapshots();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: Text('로그인 완료')),
          StreamBuilder<DocumentSnapshot>(
            stream: stream,
            builder: (ctx, ss) {
              if (ss.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (ss.hasError) {
                // throw ss.error!;
                return Center(
                  child: Column(
                    children: [
                      const UserImage(image: null),
                      Text(_auth.currentUser!.email!),
                      const Text('unknown'),
                    ],
                  ),
                );
              } else if (ss.hasData) {
                dynamic data = ss.data!.data();
                return Center(
                  child: Column(
                    children: [
                      UserImage(
                          image: data == null || data['image_url'] == null
                              ? null
                              : NetworkImage(data['image_url'])),
                      Text(_auth.currentUser!.email!),
                      Text(data == null ? 'unknown' : data['username']),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                _auth.signOut();
              },
              child: const Text('로그아웃'),
            ),
          ),
        ],
      ),
    );
  }
}
