import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/riwayat_tiket.dart';
import 'package:sumbermaron/layouts/partials/tiket_aktif.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  int _selectedRiwayat = 0;

  void _onTapRiwayat(int index) {
    setState(() {
      _selectedRiwayat = index;
    });
  }

  List<Widget> riwayat = [
    TiketAktif(),
    RiwayatTiket(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket', style: TextStyle(color: kWhiteColor)),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
          child: Expanded(
        child: Column(
          children: [
            SizedBox(height: getHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedRiwayat = 0;
                        _onTapRiwayat(_selectedRiwayat);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedRiwayat == 0
                            ? kPrimaryColor
                            : kGreyColor[50]),
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Tiket Aktif',
                            style: TextStyle(
                                color: _selectedRiwayat == 0
                                    ? kWhiteColor
                                    : kPrimaryColor,
                                fontWeight: FontWeight.bold)))),
                SizedBox(width: getWidth(20)),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedRiwayat = 1;
                        _onTapRiwayat(_selectedRiwayat);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedRiwayat == 1
                            ? kPrimaryColor
                            : kGreyColor[50]),
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Riwayat Tiket',
                            style: TextStyle(
                                color: _selectedRiwayat == 1
                                    ? kWhiteColor
                                    : kPrimaryColor,
                                fontWeight: FontWeight.bold)))),
              ],
            ),
            SizedBox(height: getHeight(20)),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: riwayat[_selectedRiwayat],
            ))
          ],
        ),
      )),
    );
  }
}
