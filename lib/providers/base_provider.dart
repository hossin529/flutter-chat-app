import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool _busy = false;
  String _message;

  bool get busy => _busy;
  String get message => _message;

  setBusy(bool val) {
    _busy = val;
    notifyListeners();
  }

  setMessage(String val) {
    _message = val;
    _busy = false;
    notifyListeners();
  }
}
