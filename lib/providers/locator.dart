import 'package:chat_app/providers/conversation_provider.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:get_it/get_it.dart';

import 'auth_provider.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => ConversationProvider());
  locator.registerFactory(() => AuthProvider());
  locator.registerLazySingleton(() => UserProvider());
}
