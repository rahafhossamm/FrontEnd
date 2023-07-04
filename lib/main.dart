import 'package:flutter/material.dart';
import 'package:llibrary/LoginPage.dart';
import 'package:llibrary/payment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Payment()

    );
  }
}

