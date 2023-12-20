import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/detail_profil.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  HttpApi dataResponse = HttpApi();
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerTelepon = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    var dataPengguna = muatAkun();

    setState(() {
      _controllerNama.text = dataPengguna['nama'];
      _controllerTelepon.text = dataPengguna['telepon'];
      _controllerEmail.text = dataPengguna['email'];
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerEmail.dispose();
    _controllerTelepon.dispose();
    super.dispose();
  }

  String? textMessage = '';

  var isNama = true;
  var isTelepon = true;
  var isEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MainScreen(pilihScreen: 2)));
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: Text(
          'Edit Profil',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: getHeight(630),
              child: Column(
                children: [
                  SizedBox(height: getHeight(30)),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Lengkap',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          SizedBox(height: getHeight(10)),
                          TextField(
                            controller: _controllerNama,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama lengkap anda',
                              suffixIcon: Icon(CupertinoIcons.person),
                            ),
                            onChanged: (String value) {
                              var nama = true;
                              if (value == '') {
                                nama = false;
                              }
                              setState(() {
                                isNama = nama;
                              });
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: getHeight(20)),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Telepon',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          SizedBox(height: getHeight(10)),
                          TextField(
                            controller: _controllerTelepon,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Masukkan no telepon anda',
                              suffixIcon:
                                  Icon(CupertinoIcons.device_phone_portrait),
                            ),
                            onChanged: (String value) {
                              var telepon = true;
                              if (value == '') {
                                telepon = false;
                              }
                              setState(() {
                                isTelepon = telepon;
                              });
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: getHeight(20)),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'E-mail',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          SizedBox(height: getHeight(10)),
                          TextField(
                            controller: _controllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
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
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: getHeight(30)),
                    child: Text(
                      textMessage ?? '',
                      style: TextStyle(color: kRedColor),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: (isNama && isTelepon && isEmail)
                    ? () {
                        var nama = _controllerNama.text;
                        var telepon = _controllerTelepon.text;
                        var email = _controllerEmail.text;
                        HttpApi.editUser(nama, telepon, email).then((value) {
                          dataResponse = value;
                          if (dataResponse.textMessage ==
                              'Edit akun user berhasil') {
                            var data = muatAkun();
                            Map<String, dynamic> dataPengguna = {
                              "idUser": data['idUser'],
                              "nama": nama,
                              "email": email,
                              "telepon": telepon,
                              "apiKey": data['apiKey'],
                            };
                            simpanAkun(dataPengguna);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailProfil()));
                          } else {
                            setState(() {
                              textMessage = dataResponse.textMessage;
                            });
                          }
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: Text(
                  'Simpan Profil',
                  style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: getHeight(50))
          ],
        ),
      )),
    );
  }
}
