import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/service.dart';

void main() {
  final service = Service();

  runApp(
    App(service),
  );
}
