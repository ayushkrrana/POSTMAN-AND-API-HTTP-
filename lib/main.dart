import 'package:apipractice/Models/example_four.dart';
import 'package:apipractice/example_three_api.dart';
import 'package:apipractice/example_two_api.dart';
import 'package:apipractice/homepage.dart';
import 'package:apipractice/image_uploadfile.dart';
import 'package:apipractice/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageUploadFile(),
    );
  }
}
