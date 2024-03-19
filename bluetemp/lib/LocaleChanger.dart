import 'package:flutter/material.dart';

class LocaleChanger extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void set(String language) {
    _locale = Locale(language);
    notifyListeners();
  }
}
