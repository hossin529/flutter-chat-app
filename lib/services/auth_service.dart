import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthService extends BaseApi {
  Future<http.Response> getUser() async {
    return await api.httpGet('user');
  }

  Future<http.Response> login(String email, password) async {
    return await api.httpPost('login', {'email': email, 'password': password});
  }

  Future<http.Response> register(UserModel user) async {
    return await api.httpPost('register',
        {'email': user.email, 'password': user.password, 'name': user.name});
  }

  Future<http.Response> logout() async {
    return await api.httpPost('logout', {});
  }
}
