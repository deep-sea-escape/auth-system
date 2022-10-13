import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/auth/auth_form.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    setState(() {
      _isLoading = true;
    });
    var userCredential;
    try {
      if (isLogin) {
        // userCredential = SIGN_IN(email, password)
      } else {
        // userCredential = SIGN_UP(email, password)

        if (image != null) {
          // save image file to the storage
        }
        // update user info
      }
    } on Exception catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.toString().isNotEmpty) {
        message = err.toString();
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
