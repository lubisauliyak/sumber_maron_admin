import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/screens/login_screen.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({super.key});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  HttpApi dataResponse = HttpApi();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerTelepon = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerKatasandi = TextEditingController();

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerEmail.dispose();
    _controllerKatasandi.dispose();
    _controllerTelepon.dispose();
    super.dispose();
  }

  String? textMessage = '';

  var isNama = false;
  var isTelepon = false;
  var isEmail = false;
  var isKatasandi = false;
  var isPasswordVisible = false;

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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                          controller: _controllerNama,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Nama Lengkap',
                            hintText: 'Masukkan nama lengkap anda',
                            suffixIcon: Icon(CupertinoIcons.person),
                          ),
                          onChanged: (String value) {
                            var nama = false;
                            if (value != '') {
                              nama = true;
                            }
                            setState(() {
                              isNama = nama;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: getHeight(30)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _controllerTelepon,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'No Telepon',
                            hintText: 'Masukkan no telepon anda',
                            suffixIcon:
                                Icon(CupertinoIcons.device_phone_portrait),
                          ),
                          onChanged: (String value) {
                            var telepon = false;
                            if (value != '') {
                              telepon = true;
                            }
                            setState(() {
                              isTelepon = telepon;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: getHeight(30)),
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
                          obscureText: isPasswordVisible ? false : true,
                          decoration: InputDecoration(
                            labelText: 'Kata Sandi',
                            hintText: 'Masukkan kata sandi anda',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(isPasswordVisible
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
              ),
              SizedBox(height: getHeight(10)),
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: (isNama && isTelepon && isEmail && isKatasandi)
                      ? () {
                          String nama = _controllerNama.text;
                          String telepon = _controllerTelepon.text;
                          String email = _controllerEmail.text;
                          String kataSandi = _controllerKatasandi.text;
                          HttpApi.registrasiUser(
                                  nama, telepon, email, kataSandi)
                              .then((value) {
                            dataResponse = value;
                            if (dataResponse.textMessage ==
                                'Pendaftaran berhasil') {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
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
                    'Daftar',
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: getHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah Punya Akun? ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: const Text('Masuk Di Sini',
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
