import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/fake/fake_chat_repository.dart';
import 'package:chat_app/repository/firebase/firestore_chat_repository.dart';
import 'package:chat_app/viewmodel/chat_view_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChatViewModel - FakeChatRepository', () async {
    final viewModel = ChatViewModel(FakeChatRepository());

    await viewModel.fetch();

    expect(viewModel.chatList.length, 3);

    await viewModel.pushMessage(
        'test', ChatUser('email', 'profileUrl', 'name'));

    expect(viewModel.chatList.length, 4);
  });

  test('ChatViewModel - FakeFirebaseFirestore', () async {
    final viewModel = ChatViewModel(
        FirestoreChatRepository(firebaseFirestore: FakeFirebaseFirestore()));

    await viewModel.fetch();

    expect(viewModel.chatList.length, 0);

    await viewModel.pushMessage(
        'test', ChatUser('email', 'profileUrl', 'name'));

    expect(viewModel.chatList.length, 1);
  });
}
