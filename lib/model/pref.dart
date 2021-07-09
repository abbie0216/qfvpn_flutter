import 'dart:convert';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/bean/node/node_list_resp.dart';
import 'api/bean/token.dart';

class Pref {

  static const String PREF_TOKEN = 'pref_token';
  Token? _token;
  static const String PREF_OPTION_MODE = 'pref_option_mode';
  int? _optionMode;
  static const String PREF_OPTION_LINE = 'pref_option_LINE';
  Items? _optionLine;

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

  void setupOptionMode(int mode) async {
    var prefs = await SharedPreferences.getInstance();
    _optionMode = mode;
    await prefs.setInt(PREF_OPTION_MODE, mode);
  }

  Future<int?> getOptionMode() async {
    if (_optionMode == null) {
      var prefs = await SharedPreferences.getInstance();
      _optionMode = prefs.getInt(PREF_OPTION_MODE);
    }
    Fimber.d('getOptionMode $_optionMode');
    return _optionMode;
  }

  void clearOptionMode() async {
    _optionMode = 0;
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(PREF_OPTION_MODE);
  }

  void setupOptionLine(Items line) async {
    var prefs = await SharedPreferences.getInstance();
    _optionLine = line;
    await prefs.setString(PREF_OPTION_LINE, jsonEncode(line));
  }

  Future<Items?> getOptionLine() async {
    if (_optionLine == null) {
      var prefs = await SharedPreferences.getInstance();
      var pOptionLine = prefs.getString(PREF_OPTION_LINE);
      if (pOptionLine == null || pOptionLine.isEmpty) {
        Fimber.d('getOptionLine null');
        return null;
      }
      final optionLineMap = jsonDecode(prefs.getString(PREF_OPTION_LINE)!);
      _optionLine = Items.fromJson(optionLineMap);
    }
    Fimber.d('getOptionLine $_optionLine');
    return _optionLine;
  }

  void clearOptionLine() async {
    _optionLine = null;
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(PREF_OPTION_LINE);
  }

}
