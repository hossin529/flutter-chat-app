import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import '../../style.dart';

class MyMessageCard extends StatelessWidget {
  final MessageModal message;
  const MyMessageCard({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: EdgeInsets.all(21),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: Style.darkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomLeft: Radius.circular(28),
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
    );
  }
}
