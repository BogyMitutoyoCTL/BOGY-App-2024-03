import 'package:flutter/material.dart';

class AppSettingsChanger extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLanguage(String language) {
    _locale = Locale(language);
    refreshApp();
  }

  void refreshApp() {
    notifyListeners();
  }
}
