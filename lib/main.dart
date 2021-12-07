// native
import 'package:flutter/material.dart';

// application
import 'screens/welcome/screen.dart';

void main() {
  runApp(const BormentalApplication());
}

class BormentalApplication extends StatelessWidget {
  const BormentalApplication({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}