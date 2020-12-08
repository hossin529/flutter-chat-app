import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../../style.dart';

class FriendMessageCard extends StatelessWidget {
  final MessageModal message;
  final String imageUrl;
  const FriendMessageCard({
    Key key,
    this.message,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl != null
                ? imageUrl
                : 'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png'),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Container(
              width: 310,
              padding: EdgeInsets.all(21),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Style.primaryColor,
                    Style.secondaryColor,
                    Style.secondaryColor,
                    Style.secondaryColor,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  )),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${message.body}',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
