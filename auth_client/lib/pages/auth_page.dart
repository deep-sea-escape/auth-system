import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(
        // _submitAuthForm,
        _isLoading,
        // updateUserInfo: _updateUserInfo,
      ),
    );
  }
}
