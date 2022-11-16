import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GoogleAuthService extends AuthService {
  GoogleAuthService();

  @override
  Future<UserCredential> signIn() {
    return _signInWithGoogle();
  }

  @override
  Future<UserCredential> signUp() {
    return _signInWithGoogle();
  }

  @override
  Future<void> updateUserImage(UserCredential userCredential) {
    return Future(() => null); // do nothing
  }

  @override
  Map<String, dynamic> getUserInfo(UserCredential userCredential) {
    final User user = userCredential.user!;
    return {
      'email': user.email,
      'username': user.displayName,
      'image_url': user.photoURL,
    };
  }

  Future<UserCredential> _signInWithGoogle() async {
    if (kIsWeb) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/userinfo.profile');
      // .addScope('https://www.googleapis.com/auth/contacts.readonly');

      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
      // Once signed in, return the UserCredential
      return await firebaseAuth.signInWithPopup(googleProvider);

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await firebaseAuth.signInWithCredential(credential);
    }
  }
}
