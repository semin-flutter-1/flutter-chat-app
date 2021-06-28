import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreChatRepository extends Repository<Chat> {
  final chatRef =
      FirebaseFirestore.instance.collection('messages').withConverter(
            fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
            toFirestore: (chat, _) => chat.toJson(),
          );

  @override
  Future<void> add(Chat item) async {
    await chatRef.add(item);
  }

  @override
  Future<List<Chat>> getAll() async {
    final chats = await chatRef.get();
    return chats.docs.map((e) => e.data()).toList();
  }
}
