import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/screans/home_screan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const homescrean(),
    );
  }
}
