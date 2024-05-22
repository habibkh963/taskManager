import 'package:flutter/material.dart';

import '../features/Todo/Presentaion/Screens/ShowTodoScreen.dart';

onGenerateRoute(settings) {
  switch (settings.name) {
    case '/':
      MaterialPageRoute(
        builder: (context) => ShowTodoScreen(title: "title"),
      );
    default:
      '/';
  }
}
