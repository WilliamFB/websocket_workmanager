import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'home_page.dart';

void main() => runApp(const MyApp());

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'abc':
        print('Task: $task');
        break;
      default:
    }

    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}
