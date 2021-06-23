import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUserRepository extends UserRepository {
  @override
  Future<ChatUser?> login() async {
    UserCredential userCredential = await signInWithGoogle();

    if (userCredential.user == null) {
      return null;
    }

    return ChatUser(
        userCredential.user?.email ?? '',
        userCredential.user?.photoURL ?? '',
        userCredential.user?.displayName ?? '');
  }

  @override
  void logout() {
    // TODO: implement logout
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

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
}
