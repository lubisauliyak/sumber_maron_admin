import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/home_screen.dart';
import 'package:official_sumbermaron/layouts/screen/registrasi_screen.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';
import 'package:simple_shadow/simple_shadow.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerInput = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerInput.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  bool isPasswordVisible = true;
  bool isRemember = true;

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
                          opacity: 0.5,
                          color: kSecondaryColor,
                          offset: const Offset(5, 5),
                          sigma: 2,
                          child: Image.asset('assets/images/smlogo.png',
                              height: getHeight(200)))),
                  SizedBox(height: getHeight(50)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: TextField(
                      controller: _controllerInput,
                      decoration: InputDecoration(
                        labelText: 'Email atau Username',
                        hintText: 'Masukkan email atau username.',
                        suffixIcon: Icon(CupertinoIcons.person),
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
                  SizedBox(height: getHeight(10)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isRemember,
                              onChanged: (value) {
                                setState(() {
                                  isRemember = value ?? false;
                                });
                              },
                            ),
                            Text("Tetap masuk"),
                          ],
                        ),
                        TextButton(
                            onPressed: () {}, child: Text('Lupa kata sandi?'))
                      ],
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor),
                    child: Text(
                      'Masuk',
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(20)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegistrasiScreen()));
                    },
                    child: Text('Belum mempunyai akun? Daftar disini.')),
                SizedBox(height: getHeight(30)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
