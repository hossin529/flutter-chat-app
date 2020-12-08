import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseApi {
  Future<http.Response> updateUser(UserModel user) async {
    return await api
        .httpPost('update', {'email': user.email, 'name': user.name});
  }

  Future<http.Response> uploadImage(var file) async {
    return await api.httpPostWithFile('upload', file: file);
  }

  Future<http.Response> setFcmToken(String token) async {
    return await api.httpPost('fcm', {'fcm_token': token.toString()});
  }
}
