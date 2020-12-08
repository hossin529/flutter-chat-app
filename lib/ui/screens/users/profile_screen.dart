import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/screens/users/edit_profile_screen.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:chat_app/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EditProfileScreen())))
          ],
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4,
            ),
            Center(
              child: Container(
                width: SizeConfig.screenWidth * 0.3,
                height: SizeConfig.screenWidth * 0.3,
                child: ClipOval(
                  child: Image.network(
                    provider.user.imageUrl != null
                        ? provider.user.imageUrl
                        : 'https://s3.amazonaws.com/37assets/svn/765-default-avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 2,
            ),
            Text(
              '${provider.user.name}',
              style: Style.appNameTextStyle,
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal,
            ),
            Text(
              '${provider.user.email}',
            ),
          ],
        ));
  }
}
