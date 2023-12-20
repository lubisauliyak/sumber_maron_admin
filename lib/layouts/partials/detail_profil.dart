import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/edit_profil.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class DetailProfil extends StatelessWidget {
  const DetailProfil({super.key});

  @override
  Widget build(BuildContext context) {
    var dataPengguna = muatAkun();

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
          'Detail Profil',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(630),
              child: Column(
                children: [
                  SizedBox(height: getHeight(30)),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: kGreyColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        buildDataProfil('Nama Lengkap', dataPengguna['nama'],
                            CupertinoIcons.person),
                        Container(
                            height: 1,
                            color: kGreyColor,
                            margin:
                                EdgeInsets.symmetric(vertical: getHeight(20))),
                        buildDataProfil('No Telepon', dataPengguna['telepon'],
                            CupertinoIcons.device_phone_portrait),
                        Container(
                            height: 1,
                            color: kGreyColor,
                            margin:
                                EdgeInsets.symmetric(vertical: getHeight(20))),
                        buildDataProfil('E-mail', dataPengguna['email'],
                            CupertinoIcons.mail),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditProfil()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: Text(
                  'Edit Profil',
                  style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: getHeight(50))
          ],
        ),
      ),
    );
  }

  Widget buildDataProfil(String label, String value, IconData iconData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: kPrimaryColor)),
          SizedBox(height: getHeight(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              Icon(iconData, color: kGreyColor),
            ],
          )
        ],
      ),
    );
  }
}
