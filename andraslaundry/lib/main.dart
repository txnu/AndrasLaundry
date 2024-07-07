import 'package:andraslaundry/Login/login.dart';
import 'package:andraslaundry/Screens/Admin/Screens/TransactionScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginForm(),
        "transaksi": (context) => TransaksiScreen(),
      },
    );
  }
}
