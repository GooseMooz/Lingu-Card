import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_page.dart';

void main() {
  runApp(LinguCard());
}

class LinguCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lingu Card',
      theme: ThemeData(
        backgroundColor: BackgroundColor,
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}