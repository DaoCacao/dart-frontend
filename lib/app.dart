import 'package:flutter/material.dart';
import 'package:frontend/enter_screen.dart';
import 'package:frontend/service.dart';

class App extends StatelessWidget {
  final Service service;

  const App(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnterScreen(service),
    );
  }
}
