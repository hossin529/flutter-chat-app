import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/ui/screens/welcome_screen.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:chat_app/ui/style.dart';
import 'package:chat_app/ui/widgets/cards/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/screens/chat_screen.dart';
import 'package:provider/provider.dart';

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ConversationProvider>(context).getConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var provider = Provider.of<ConversationProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Style.darkColor,
        title: Text('Conversations'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            Provider.of<AuthProvider>(context).logout();
            Navigator.of(context).pushNamedAndRemoveUntil(
                WelcomeScreen.routeName, (Route<dynamic> route) => false);
          },
          icon: Icon(Icons.search),
        ),
      ),
      body: Center(
        child: provider.busy
            ? CircularProgressIndicator()
            : ListView.builder(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                itemCount: provider.concersations.length,
                itemBuilder: (context, index) => ConversationCard(
                    conversation: provider.concersations[index],
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ChatScreen(
                                conversation: provider.concersations[index],
                              )));
                    }),
              ),
      ),
    );
  }
}
