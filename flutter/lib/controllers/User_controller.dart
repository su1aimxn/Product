import 'package:flutter/material.dart';

class UserPageController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
  }
}
