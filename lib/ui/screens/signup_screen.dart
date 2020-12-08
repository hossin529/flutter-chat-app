import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/size_config.dart';
import 'package:chat_app/ui/style.dart';
import 'package:chat_app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = 'sign-up';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      key: _scafoldKey,
      backgroundColor: Style.darkColor,
      body: Provider.of<AuthProvider>(context).busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                Center(
                    child: Text(
                  'Sign Up',
                  style: Style.appNameTextStyle,
                )),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 4),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
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
                        TextFormField(
                          obscureText: true,
                          controller: _password,
                          decoration: Style.inputDecoration('Password'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
                            } else if (v.trim().length < 6) {
                              return 'this password is too short';
                            } else
                              return null;
                          },
                          onSaved: (v) {
                            provider.user.password = v;
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              Style.inputDecoration('Password Confirmation'),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'input require';
                            } else if (v.trim() != _password.text.trim()) {
                              return ' passwords not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: PrimaryButton(
          onTap: () async {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              var result = await provider.register();
              if (result) {
                print('done');
                Navigator.of(context)
                    .pushReplacementNamed(MainScreen.routeName);
              } else {
                _scafoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(Provider.of<AuthProvider>(context).message),
                ));
                print('error');
              }
            } else
              print('is not validate');
          },
          child: Text(
            'Save',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21),
          ),
        ),
      ),
    );
  }
}
