import 'package:flutter/material.dart';

class HomeAdminScreens extends StatefulWidget {
  const HomeAdminScreens({super.key});

  @override
  State<HomeAdminScreens> createState() => _HomeAdminScreensState();
}

class _HomeAdminScreensState extends State<HomeAdminScreens> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Selamat Datang Dihalaman Admin")),
    );
  }
}
