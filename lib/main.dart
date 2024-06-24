import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(RestaurantSearchApp());
}

class RestaurantSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Search',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
