import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/layouts/screens/registrasi_screen.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  HttpApi dataResponse = HttpApi();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerKatasandi = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerKatasandi.dispose();
    super.dispose();
  }

  String? textMessage = '';

  var isEmail = false;
  var isKatasandi = false;
  var isKatasandiVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: getHeight(680),
                child: Column(
                  children: [
                    SizedBox(height: getHeight(50)),
                    Hero(
                        tag: 'logo-app',
                        child: Image.asset('assets/images/smlogo.png',
                            width: getWidth(200))),
                    SizedBox(height: getHeight(50)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Masukkan e-mail anda',
                          suffixIcon: Icon(CupertinoIcons.mail),
                        ),
                        onChanged: (String value) {
                          bool isValidEmail = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([a-z0-9-]+\.)+[a-z]{2,}$',
                            caseSensitive: false,
                          ).hasMatch(value);

                          setState(() {
                            isEmail = isValidEmail;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: getHeight(30)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _controllerKatasandi,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isKatasandiVisible ? false : true,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          hintText: 'Masukkan kata sandi anda',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isKatasandiVisible = !isKatasandiVisible;
                                });
                              },
                              icon: Icon(isKatasandiVisible
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash)),
                        ),
                        onChanged: (String value) {
                          var katasandi = false;
                          if (value != '') {
                            katasandi = true;
                          }
                          setState(() {
                            isKatasandi = katasandi;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: getHeight(20), bottom: getHeight(10)),
                      child: Text(
                        textMessage ?? '',
                        style: const TextStyle(color: kRedColor),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: getHeight(10)),
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: (isEmail && isKatasandi)
                      ? () {
                          HttpApi.loginUser(_controllerEmail.text,
                                  _controllerKatasandi.text)
                              .then((value) {
                            dataResponse = value;
                            if (dataResponse.textMessage == 'Login berhasil') {
                              HttpApi.tiketAktif();
                              HttpApi.riwayatTiket();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()));
                            } else {
                              setState(() {
                                textMessage = dataResponse.textMessage;
                              });
                            }
                          });
                        }
                      : null,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: getHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum Punya Akun? ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const RegistrasiScreen()));
                      },
                      child: const Text('Daftar Di Sini',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold)))
                ],
              ),
              SizedBox(height: getHeight(30))
            ],
          ),
        ),
      ),
    );
  }
}
