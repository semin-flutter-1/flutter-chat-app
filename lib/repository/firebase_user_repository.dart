import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository extends UserRepository {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  ChatUser? _user;

  @override
  ChatUser? get user => _user;

  @override
  Future<ChatUser?> login() async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential == null) {
      return null;
    }

    await _googleSignIn.signIn();

    _user = ChatUser(
        userCredential.user?.email ?? '',
        userCredential.user?.photoURL ?? '',
        userCredential.user?.displayName ?? '');
    return _user;
  }

  @override
  Future logout() async {
    await _googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Stream<ChatUser?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges().map((user) {
      if (user != null) {
        _user = ChatUser(user.email, user.photoURL, user.displayName);
        return _user;
      }
      return null;
    });
  }
}
