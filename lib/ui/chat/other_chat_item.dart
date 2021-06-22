import 'package:chat_app/model/chat.dart';
import 'package:flutter/material.dart';

class OtherChatItem extends StatelessWidget {
  final Chat chat;

  const OtherChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      chat.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8),
                    Text(timeNow()),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(chat.message),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String timeNow() {
  String result;
  if (TimeOfDay.now().hour > 12) {
    result = (TimeOfDay.now().hour - 12).toString() +
        ':' +
        TimeOfDay.now().minute.toString() +
        'PM';
  } else {
    result = TimeOfDay.now().hour.toString() +
        ':' +
        TimeOfDay.now().minute.toString() +
        'AM';
  }
  return result;
}
