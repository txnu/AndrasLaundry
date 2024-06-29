// ignore_for_file: unused_local_variable

import 'package:andraslaundry/API/configAPI.dart';
import 'package:andraslaundry/Screens/User/HomeUserScreens.dart';
import 'package:andraslaundry/Utils/constant.dart';
import 'package:andraslaundry/register/register.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController txtUsername = TextEditingController(),
      txtPassword = TextEditingController();

  var textColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Login'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Form(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/laundry.png",
                  height: 140,
                  width: 140,
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: txtUsername,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.abc),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterForm(),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        prosesLogin(txtUsername.text, txtPassword.text);
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Masuk",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function

  var dio = Dio();
  Response? response;
  var getUser;

  void prosesLogin(username, password) async {
    utilApps.showDialog(context);

    bool status;
    var msg;
    var dataUser;

    String userId;

    try {
      response = await dio
          .post(urlLogin, data: {'username': username, 'password': password});
      status = response!.data['sukses'];
      msg = response!.data['msg'];

      if (status) {
        getUser = response!.data['data'];
        userId = getUser['_id'];
        password = txtPassword.text;
        AwesomeDialog(
            context: context,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            showCloseIcon: true,
            title: 'Berhasil',
            desc: 'Selamat ya kamu berhasil login😊',
            btnOkOnPress: () {
              utilApps.hideDialog(context);
              dataUser = response!.data['data'];
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeUserScreens(
                    userId: userId.toString(),
                    password: password.toString(),
                  ),
                ),
              );
              // if (dataUser['role'] == 1) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => HomeUserScreens(
              //         userId: userId.toString(),
              //         password: password.toString(),
              //       ),
              //     ),
              //   );
              // if (dataUser['role'] == 1) {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => HomeUserScreens(
              //         userId: userId.toString(),
              //         password: password.toString(),
              //       ),
              //     ),
              //   );
              // } else {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => HomeAdminScreens(),
              //     ),
              //   );
              // }
            }).show();
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          showCloseIcon: true,
          title: 'Gagal',
          desc: 'Aduh gagal login karna $msg 😓',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {}
  }
}
