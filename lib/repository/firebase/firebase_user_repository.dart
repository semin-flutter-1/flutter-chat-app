import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/result.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository extends UserRepository {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;

  FirebaseUserRepository({GoogleSignIn? googleSignIn, FirebaseAuth? auth})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<ChatUser?> login() async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential == null || userCredential.user == null) {
      return null;
    }

    await _googleSignIn.signIn();

    return ChatUser(userCredential.user!.email, userCredential.user!.photoURL,
        userCredential.user!.displayName);
  }

  @override
  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  @override
  Stream<Result<ChatUser>> authStateChanges() {
    return _auth.authStateChanges().map((User? user) {
      if (user != null) {
        return Result.success(
          ChatUser(user.email, user.photoURL, user.displayName),
        );
      }
      return Result.error(Exception('로그인 실패'));
    });
  }
}
