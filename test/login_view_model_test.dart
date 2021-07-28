import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/fake/fake_user_repository.dart';
import 'package:chat_app/repository/firebase/firebase_user_repository.dart';
import 'package:chat_app/viewmodel/login_view_model.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  test('login viewModel test', () async {
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'aaa@bbb.com',
      displayName: 'tester',
    );
    final auth = MockFirebaseAuth(mockUser: user);

    final fakeFirebaseAuthRepository =
        FirebaseUserRepository(googleSignIn: MockGoogleSignIn(), auth: auth);

    final viewModel =
        LoginViewModel(userRepository: fakeFirebaseAuthRepository);

    expect(viewModel.user == null, true);

    await viewModel.login();

    expect(viewModel.user == null, false);

    if (viewModel.user != null) {
      expect(viewModel.user!.name, 'tester');
      expect(viewModel.user!.email, 'aaa@bbb.com');
    }
  });

  test('fake login viewModel test', () async {
    final viewModel = LoginViewModel(userRepository: FakeUserRepository());

    expect(viewModel.user == null, true);

    ChatUser? user = await viewModel.login();

    expect(user == null, false);

    expect(user!.name, '오준석');
    expect(user.email, 'bbb@aaa.com');
  });
}
