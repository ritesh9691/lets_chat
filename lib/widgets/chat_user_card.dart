import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lets_chat/main.dart';
import 'package:lets_chat/models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
 final ChatUser user;
  ChatUserCard({super.key,required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: mq.height * .015, vertical: 4),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title: Text(widget.user.name.toString()),
          subtitle: Text(
           widget.user.about.toString(),
            maxLines: 1,
          ),
          trailing: Text(
            "12:00 pm",
            style: TextStyle(color: Color.fromARGB(135, 27, 1, 1),fontSize: 14),
          ),
        ),
      ),
    );
  }
}
