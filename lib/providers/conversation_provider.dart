import 'dart:convert';

import 'package:chat_app/models/conversation_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/providers/base_provider.dart';
import 'package:chat_app/services/conversation_service.dart';

class ConversationProvider extends BaseProvider {
  ConversationService _conversationService = ConversationService();
  List<ConversationModel> _concersations = List();
  List<ConversationModel> get concersations => _concersations;

  Future<List<ConversationModel>> getConversations() async {
    if (_concersations.isNotEmpty) return _concersations;
    setBusy(true);
    var response = await _conversationService.getConversations();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach((conversation) =>
          _concersations.add(ConversationModel.fromJson(conversation)));
      print(response.body);
      notifyListeners();
      setBusy(false);
    }
    return _concersations;
  }

  Future<MessageModal> storeMessage(MessageModal message) async {
    setBusy(true);
    var response = await _conversationService.storeMessage(message);
    // print(response.body);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      setBusy(false);
      return MessageModal.fromJson(data['data']);
    }
    setBusy(false);
    return null;
  }
}
