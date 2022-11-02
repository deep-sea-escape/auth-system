import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../user/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    XFile? image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  bool isLoading;
  AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  XFile? _userImage;

  void _setUserImage(XFile image) {
    _userImage = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // Close Soft Keyboard !
    /*
    if (_userImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick an image.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    */
    if (isValid) {
      _formKey.currentState!.save(); // 모든 Input의 onSaved를 발동시킴
      // Use those values to send our auth request...
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(30),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: const Color.fromARGB(255, 245, 245, 240),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(onPicked: _setUserImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (val) {
                      if (val == null || val.isEmpty || !val.contains('@')) {
                        return 'Please enter a valid email address.';
                      } else {
                        return null; // 에러가 없다면 null 리턴해야 함
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: '이메일'),
                    onSaved: (value) {
                      _userEmail = value!;
                      // setState 필요없다. 다시 그릴필요 있는 데이터가 아니라 뒤에서 발생하는 일이기 때문
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 2) {
                          return 'Please enter at least 2 characters.';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(labelText: '닉네임'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(labelText: '비밀번호'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  if (widget.isLoading)
                    const CircularProgressIndicator()
                  else ...[
                    if (_isLogin) ...[
                      // const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            child: const Text('아이디 찾기'),
                            onPressed: () {},
                          ),
                          // VerticalDivider(),
                          TextButton(
                            child: const Text('비밀번호 찾기'),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? '로그인' : '회원가입'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_isLogin ? '처음인가요?' : '이미 계정이 있나요?'),
                        TextButton(
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin ? '회원가입' : '로그인')),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
