import 'dart:convert';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/bean/token.dart';

class Pref {

  static const String PREF_TOKEN = 'pref_token';
  Token? _token;

  void setupToken(Token token) async {
    var prefs = await SharedPreferences.getInstance();
    _token = null;
    await prefs.setString(PREF_TOKEN, jsonEncode(token));
  }

  Future<Token?> getToken() async {
    if (_token == null) {
      var prefs = await SharedPreferences.getInstance();
      var pToken = prefs.getString(PREF_TOKEN);
      if (pToken == null || pToken.isEmpty) {
        Fimber.d('getToken null');
        return _token;
      }
      final tokenMap = jsonDecode(prefs.getString(PREF_TOKEN)!);
      _token = Token.fromJson(tokenMap);
    }
    Fimber.d('getToken $_token');
    return _token;
  }

  void clearToken() async {
    _token = null;
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(PREF_TOKEN);
  }
}
