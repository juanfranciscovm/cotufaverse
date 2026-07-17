import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool _isEnglish = false;
  bool _hideAdultContent = false;

  bool get isDarkMode => _isDarkMode;
  bool get isEnglish => _isEnglish;
  bool get hideAdultContent => _hideAdultContent;

  SettingsProvider() {
    _loadPreferences();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool("isDarkMode") ?? true;
    _isEnglish = prefs.getBool("isEnglish") ?? false;
    _hideAdultContent = prefs.getBool("hideAdultContent") ?? false;
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    _savePref("isDarkMode", value);
    notifyListeners();
  }

  set isEnglish(bool value) {
    _isEnglish = value;
    _savePref("isEnglish", value);
    notifyListeners();
  }

  set hideAdultContent(bool value) {
    _hideAdultContent = value;
    _savePref("hideAdultContent", value);
    notifyListeners();
  }

  _savePref(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
