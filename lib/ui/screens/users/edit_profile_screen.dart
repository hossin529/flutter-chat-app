import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:chat_app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../style.dart';

class EditProfileScreen extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: provider.busy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 4),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 4,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () => provider.pickImage(),
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
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            TextFormField(
                              initialValue: '${provider.user.name}',
                              decoration: Style.inputDecoration('Full Name'),
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else
                                  return null;
                              },
                              onSaved: (v) {
                                provider.user.name = v.trim();
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            TextFormField(
                              initialValue: '${provider.user.email}',
                              decoration: Style.inputDecoration('Email'),
                              validator: (v) {
                                if (v.isEmpty) {
                                  return 'input require';
                                } else if (!isEmail(v)) {
                                  return 'email invalide';
                                }
                                return null;
                              },
                              onSaved: (v) {
                                provider.user.email = v;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: PrimaryButton(
            onTap: () async {
              if (_key.currentState.validate()) {
                _key.currentState.save();
                // print(provider.user.toJson());
                // return;
                var result = await provider.updateUser();
                if (!result) {
                  _scafoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(Provider.of<UserProvider>(context).message),
                  ));
                  print('error');
                }
              } else
                print('is not validate');
            },
            child: Text(
              'Update',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 21),
            ),
          ),
        ));
  }
}
