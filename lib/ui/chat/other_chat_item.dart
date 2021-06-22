import 'package:chat_app/model/chat.dart';
import 'package:flutter/material.dart';

class OtherChatItem extends StatelessWidget {
  final Chat chat;

  const OtherChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 30,
            backgroundImage: chat.profileUrl != null
                ? NetworkImage(chat.profileUrl!)
                : NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Suzy_at_Asia_Artist_Awards_red_carpet%2C_16_November_2016_02.jpg/250px-Suzy_at_Asia_Artist_Awards_red_carpet%2C_16_November_2016_02.jpg'),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(chat.name),
                    Text('${chat.time}'),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  child: Text(
                    chat.message,
                    maxLines: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
