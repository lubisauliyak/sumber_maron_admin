import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';
import 'package:simple_shadow/simple_shadow.dart';

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({super.key});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerTelepon = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerUsername.dispose();
    _controllerTelepon.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: getHeight(30)),
              Column(
                children: [
                  Hero(
                      tag: 'logo-app',
                      child: SimpleShadow(
                          opacity: 0.4,
                          color: kSecondaryColor,
                          offset: const Offset(4, 4),
                          sigma: 1,
                          child: Image.asset('assets/images/smlogo.png',
                              height: getHeight(100)))),
                  SizedBox(height: getHeight(50)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: TextField(
                      controller: _controllerNama,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Masukkan nama lengkap.',
                        suffixIcon: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: TextField(
                      controller: _controllerUsername,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Masukkan username.',
                        suffixIcon: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: TextField(
                      controller: _controllerTelepon,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'No Telepon',
                        hintText: 'Masukkan nomer telepon.',
                        suffixIcon: Icon(CupertinoIcons.phone),
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: TextField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan email.',
                        suffixIcon: Icon(CupertinoIcons.mail),
                      ),
                    ),
                  ),
                  SizedBox(height: getHeight(20)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: TextField(
                      controller: _controllerPassword,
                      obscureText: isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        hintText: 'Masukkan kata sandi.',
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye),
                          onPressed: () {
                            setState(
                              () {
                                isPasswordVisible = !isPasswordVisible;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: getHeight(30)),
              Column(children: [
                Container(
                  width: double.infinity,
                  height: getHeight(50),
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor),
                    child: Text(
                      'Daftar',
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(20)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Sudah mempunyai akun? Masuk disini.')),
                SizedBox(height: getHeight(30)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
