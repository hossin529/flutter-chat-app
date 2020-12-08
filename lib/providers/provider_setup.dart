import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/providers/locator.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider(
    builder: (context) => locator<ConversationProvider>(),
  ),
  ChangeNotifierProvider(
    builder: (context) => locator<AuthProvider>(),
  ),
  ChangeNotifierProvider(
    builder: (context) => locator<UserProvider>(),
  ),
];
