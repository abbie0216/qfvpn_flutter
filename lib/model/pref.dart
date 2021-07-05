import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api/bean/token.dart';

class Pref {

  static const String PREF_TOKEN = 'pref_token';
  Token? _token;

  void setupToken(Token token) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_TOKEN, jsonEncode(token));
  }

  Future<Token?> getToken() async {
    if (_token == null) {
      var prefs = await SharedPreferences.getInstance();
      final tokenMap = jsonDecode(prefs.getString(PREF_TOKEN) ?? '');
      _token = Token.fromJson(tokenMap);
    }
    return _token;
  }

}
