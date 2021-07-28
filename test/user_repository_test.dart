import 'package:chat_app/model/result.dart';
import 'package:chat_app/repository/firebase/firebase_user_repository.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  group('user_repository', () {
    test('firebase_auth로 로그인, 로그아웃 되어야한다', () async {
      final user = MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: 'aaa@bbb.com',
        displayName: 'tester',
      );
      final auth = MockFirebaseAuth(mockUser: user);

      final fakeFirebaseAuthRepository =
          FirebaseUserRepository(googleSignIn: MockGoogleSignIn(), auth: auth);

      await fakeFirebaseAuthRepository.login();
      await fakeFirebaseAuthRepository.logout();
      await fakeFirebaseAuthRepository.login();

      expect(
          fakeFirebaseAuthRepository.authStateChanges(),
          emitsInOrder([
            isA<Success>(),
            isA<Error>(),
            isA<Success>(),
          ]));
    });
  });
}
