import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/result.dart';

abstract class UserRepository {
  Future<ChatUser?> login();

  Future<void> logout();

  Stream<Result<ChatUser>> authStateChanges();
}
