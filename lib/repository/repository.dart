import 'package:chat_app/model/chat.dart';

abstract class Repository {
  Future<List<Chat>> getChatList();
}