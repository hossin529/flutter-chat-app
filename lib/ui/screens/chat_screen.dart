import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:chat_app/ui/style.dart';
import 'package:chat_app/ui/widgets/cards/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/widgets/cards/friend_message_card.dart';
import 'package:chat_app/ui/widgets/cards/my_message_card.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ConversationModel conversation;
  const ChatScreen({Key key, this.conversation}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState(this.conversation);
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageTextEditController = TextEditingController();

  final ConversationModel conversation;
  MessageModal message;
  ScrollController _scrollController = ScrollController();

  _ChatScreenState(this.conversation);

  @override
  void initState() {
    super.initState();
    message = MessageModal();
    message.conversationId = conversation.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('${conversation.user.name}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 4,
              vertical: SizeConfig.safeBlockVertical * 3,
            ),
            itemCount: conversation.messages.length,
            itemBuilder: (context, index) =>
                conversation.messages[index].userId == conversation.user.id
                    ? FriendMessageCard(
                        message: conversation.messages[index],
                        imageUrl: conversation.user.imageUrl,
                      )
                    : MyMessageCard(
                        message: conversation.messages[index],
                      ),
          )),
          // FriendMessageCard(),
          // MyMessageCard(),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Style.darkColor,
                borderRadius: BorderRadius.circular(32)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: TextField(
                  controller: messageTextEditController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message...',
                      hintStyle: TextStyle()),
                )),
                Provider.of<ConversationProvider>(context).busy
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());

                          if (messageTextEditController.text.isEmpty) return;
                          message.body = messageTextEditController.text.trim();
                          print(message.toJson());
                          await Provider.of<ConversationProvider>(context)
                              .storeMessage(message);
                          messageTextEditController.clear();
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent + 23);
                        },
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: [
                                      Style.primaryColor,
                                      Style.secondaryColor,
                                      Style.secondaryColor,
                                      Style.secondaryColor,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: Icon(Icons.send)),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
