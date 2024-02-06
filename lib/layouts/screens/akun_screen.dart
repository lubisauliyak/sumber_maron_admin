import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_profil.dart';
import 'package:sumbermaron_admin/layouts/screens/login_screen.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  @override
  Widget build(BuildContext context) {
    var dataPengguna = muatAkun();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Akun',
          style: TextStyle(color: kWhiteColor),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(30)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                dataPengguna['nama'],
                style: const TextStyle(
                    fontSize: sizeTitle, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: getHeight(40)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Akun Anda',
                    style: TextStyle(
                        color: kGreyColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DetailProfil()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.person, color: kPrimaryColor),
                              SizedBox(width: 15),
                              Text('Detail Profil',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                          Icon(CupertinoIcons.right_chevron,
                              size: 20, color: kGreyColor)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight(20)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Keluar',
                    style: TextStyle(
                        color: kGreyColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: getHeight(10)),
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text('Keluar dari akun?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(
                                    'Keluar',
                                    style: TextStyle(
                                        color: kRedColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    keluarAkun();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text(
                                    'Batalkan',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.logout_rounded, color: kRedColor),
                          const SizedBox(width: 15),
                          Text('Keluar dari ${dataPengguna['nama']}',
                              style: const TextStyle(
                                  color: kRedColor,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight(30)),
          ],
        ),
      ),
    );
  }
}
