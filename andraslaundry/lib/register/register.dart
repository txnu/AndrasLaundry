import 'package:andraslaundry/API/configAPI.dart';
import 'package:andraslaundry/Login/login.dart';
import 'package:andraslaundry/Utils/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? namalengkap;
  String? telepon;
  String? username;
  String? password;
  String? alamat;
  bool? remember = false;

  TextEditingController txtNamaLengkap = TextEditingController(),
      txtTelepon = TextEditingController(),
      txtUsername = TextEditingController(),
      txtPassword = TextEditingController(),
      txtAlamat = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Akun'),
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
                  "images/laundry.png",
                  height: 140,
                  width: 140,
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: txtNamaLengkap,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.abc),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtTelepon,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "No. Handphone",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
                SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                TextFormField(
                  controller: txtAlamat,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.abc),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    prosesRegistrasi(txtNamaLengkap.text, txtTelepon.text,
                        txtUsername.text, txtPassword.text, txtAlamat.text);
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  //vFunction

  var dio = Dio();
  Response? response;

  void prosesRegistrasi(
      namalengkap, telepon, username, password, alamat) async {
    utilApps.showDialog(context);

    bool status;
    var msg;

    try {
      response = await dio.post(urlRegister, data: {
        'namalengkap': namalengkap,
        'telepon': telepon,
        'username': username,
        'password': password,
        'alamat': alamat,
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
          desc: 'Proses registrasi berhasil, silahkan lanjutkan',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginForm(),
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
          desc: 'Aduh kamu gagal registrasi karna $msg',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {}
  }
}
