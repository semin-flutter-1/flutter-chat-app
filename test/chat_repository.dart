import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/firebase/firestore_chat_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat_repository', () {
    test('firestore 테스트', () async {
      final repository =
          FirestoreChatRepository(firebaseFirestore: FakeFirebaseFirestore());

      expect((await repository.getAll()).length, 0);

      await repository.add(Chat('test', '', 'message', 0, 'aaa@bbb.com'));

      expect((await repository.getAll()).length, 1);
    });
  });
}
