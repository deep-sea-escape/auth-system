import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/auth/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    XFile? image,
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
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child('test.jpg');
          if (kIsWeb) {
            await ref.putData(await image.readAsBytes()).then((p0) {
              print(p0);
            });
          } else {
            await ref.putFile(File(image.path)).then((p0) {
              print(p0);
            });
          }
        }

        // update user info
      }
    } on Exception catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.toString().isNotEmpty) {
        message = err.toString();
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
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
