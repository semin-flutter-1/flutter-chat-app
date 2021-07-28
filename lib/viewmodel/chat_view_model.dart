import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/push_message/push_service.dart';
import 'package:chat_app/repository/firebase/firestore_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatViewModel extends ChangeNotifier {
  final FirestoreChatRepository _repository;

  ChatViewModel(this._repository);

  Stream<QuerySnapshot<Chat>> getChatListStream() {
    return _repository.getChatRef();
  }

  Future<void> pushMessage(String text, ChatUser user) async {
    await _repository.add(Chat(
      user.name,
      user.profileUrl,
      text,
      DateTime.now().millisecondsSinceEpoch,
      user.email,
    ));

    PushService().sendPush(user.name ?? '아무개', text);
  }
}
