import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class DetailProfil extends StatelessWidget {
  const DetailProfil({super.key});

  @override
  Widget build(BuildContext context) {
    var dataPengguna = muatAkun();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
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
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                                EdgeInsets.symmetric(vertical: getHeight(10))),
                        buildDataProfil('Posisi', dataPengguna['role'],
                            CupertinoIcons.rectangle_stack_badge_person_crop),
                        Container(
                            height: 1,
                            color: kGreyColor,
                            margin:
                                EdgeInsets.symmetric(vertical: getHeight(10))),
                        buildDataProfil('No Telepon', dataPengguna['telepon'],
                            CupertinoIcons.device_phone_portrait),
                        Container(
                            height: 1,
                            color: kGreyColor,
                            margin:
                                EdgeInsets.symmetric(vertical: getHeight(10))),
                        buildDataProfil('E-mail', dataPengguna['email'],
                            CupertinoIcons.mail),
                      ],
                    ),
                  ),
                ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: kPrimaryColor)),
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
