import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/repository.dart';

class FakeRepository extends Repository {
  @override
  Future<List<Chat>> getChatList() async {
    await Future.delayed(Duration(seconds: 1));

    return [
      Chat('홍길동', null, 'hello world', 100234234234, 'aaa@aaa.com'),
      Chat(
          '홍길동',
          null,
          'hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2hello world 2',
          100234234234,
          'aaa@aaa.com'),
      Chat('한석봉', null, 'hello world 3hello world 3hello', 100234234234, 'bbb@aaa.com'),
    ];
  }
}
