import 'package:chat_app/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreChatRepository {
  final CollectionReference<Chat> _chatRef;

  FirestoreChatRepository({FirebaseFirestore? firebaseFirestore})
      : _chatRef = (firebaseFirestore ?? FirebaseFirestore.instance)
            .collection('messages')
            .withConverter(
              fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
              toFirestore: (chat, _) => chat.toJson(),
            );

  Future add(Chat item) async {
    await _chatRef.add(item);
  }

  Future<List<Chat>> getAll() async {
    final chats = await _chatRef.get();
    return chats.docs.map((e) => e.data()).toList();
  }

  Stream<QuerySnapshot<Chat>> getChatRef() {
    return _chatRef.orderBy('time', descending: true).snapshots();
  }
}
