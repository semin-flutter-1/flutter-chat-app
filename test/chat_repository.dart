import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/fake/fake_chat_repository.dart';
import 'package:chat_app/repository/firebase/firestore_chat_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('chat_repository', () {
    test('채팅 데이터가 추가되어야 한다', () async {
      final repository = FakeChatRepository();
      expect((await repository.getAll()).length, 3);

      await repository.add(Chat('test', '', 'message', 0, 'aaa@bbb.com'));

      expect((await repository.getAll()).length, 4);
    });

    test('firestore 테스트', () async {
      final repository =
          FirestoreChatRepository(firebaseFirestore: FakeFirebaseFirestore());

      expect((await repository.getAll()).length, 0);

      await repository.add(Chat('test', '', 'message', 0, 'aaa@bbb.com'));

      expect((await repository.getAll()).length, 1);
    });
  });
}
