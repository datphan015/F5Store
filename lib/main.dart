import 'package:flutter/material.dart';
import 'package:flutter_doanlt/page/product_list_screen.dart';
import 'package:flutter_doanlt/page/start.dart';
import 'package:flutter_doanlt/page/cart_screen.dart';
import 'package:flutter_doanlt/page/login.dart';
import 'package:flutter_doanlt/page/signup.dart';

void main() {
  //runApp(const MainApp());
  runApp(ShoeApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage()
    );
  }
}
class ShoeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF6699CC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6699CC),
        ),
      ),
      home: SignUpScreen(),
    );
  }
}
