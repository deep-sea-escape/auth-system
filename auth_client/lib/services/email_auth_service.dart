import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart' show XFile;

class EmailAuthService extends AuthService {
  final String email;
  final String password;
  final String? username;
  final XFile? image;
  String? imageUrl;

  EmailAuthService({
    required this.email,
    required this.password,
    this.username,
    this.image,
  });

  @override
  Future<UserCredential> signIn() {
    return _signInWithEmail(email, password);
  }

  @override
  Future<UserCredential> signUp() {
    return _signUpWithEmail(email, password);
  }

  @override
  Future<void> updateUserImage(UserCredential userCredential) async {
    imageUrl = await uploadUserImage(userCredential.user!.uid, image);
    // userCredential.user!.updatePhotoURL(imageUrl);
  }

  @override
  Map<String, dynamic> getUserInfo(UserCredential userCredential) {
    final User user = userCredential.user!;
    return {
      'email': user.email,
      'username': username,
      'image_url': imageUrl,
    };
  }

  Future<UserCredential> _signInWithEmail(String email, String password) async {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> _signUpWithEmail(String email, String password) async {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
