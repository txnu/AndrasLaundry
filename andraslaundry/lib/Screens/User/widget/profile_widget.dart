import 'package:andraslaundry/API/configAPI.dart';
import 'package:andraslaundry/Utils/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  final String namalengkap;
  final String telepon;
  final String username;
  final String password;
  final String userId;

  ProfilePage({
    required this.namalengkap,
    required this.telepon,
    required this.username,
    required this.password,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    late TextEditingController namalengkapController;
    late TextEditingController teleponController;
    late TextEditingController usernameController;
    late TextEditingController passwordController;

    namalengkapController = TextEditingController(text: namalengkap);
    teleponController = TextEditingController(text: telepon);
    usernameController = TextEditingController(text: username);
    passwordController = TextEditingController(text: password);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Pengguna'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                controller: namalengkapController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.abc),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: teleponController,
                decoration: InputDecoration(
                  labelText: "Telepon",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.call),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.abc),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  editUser(
                      context,
                      userId,
                      namalengkapController.text,
                      teleponController.text,
                      usernameController.text,
                      passwordController.text);
                },
                child: Container(
                  height: 50,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  var dio = Dio();
  Response? response;

  Future<void> editUser(BuildContext context, String userId, String newName,
      String newTelepon, String newUsername, String newPassword) async {
    utilApps.showDialog(context);

    bool status;
    var msg;

    try {
      response = await dio.put('$urlEditUser$userId', data: {
        '_id': userId,
        'namalengkap': newName,
        'telepon': newTelepon,
        'username': newUsername,
        'password': newPassword
      });
      status = response!.data['sukses'];
      msg = response!.data['msg'];

      if (status) {
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.success,
          showCloseIcon: true,
          title: 'Berhasil',
          desc: 'Data Kamu berhasil diubah',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  userId: userId,
                  namalengkap: newName,
                  telepon: newTelepon,
                  username: newUsername,
                  password: newPassword,
                ),
              ),
            );
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          showCloseIcon: true,
          title: 'Gagal',
          desc: 'Aduh data kamu gagal diubah $msg',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {}
  }
}
