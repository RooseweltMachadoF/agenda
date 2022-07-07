import 'package:flutter/cupertino.dart';

class AppController {
  static final AppController instance = AppController._();

  AppController._();

  final switchTheme = ValueNotifier<bool>(false);

  editTheme(bool value) {
    switchTheme.value = value;
  }
}
