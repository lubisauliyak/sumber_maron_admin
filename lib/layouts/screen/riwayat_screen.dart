import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/partials/riwayat_tiket_screen.dart';
import 'package:official_sumbermaron/layouts/partials/tiket_aktif_screen.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';

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
    TiketAktifScreen(),
    RiwayatTiketScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                      height: getHeight(50),
                      width: getWidth(100),
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
                      height: getHeight(50),
                      width: getWidth(100),
                      child: Text('Riwayat Tiket',
                          style: TextStyle(
                              color: _selectedRiwayat == 1
                                  ? kWhiteColor
                                  : kPrimaryColor,
                              fontWeight: FontWeight.bold)))),
            ],
          ),
          SizedBox(height: getHeight(20)),
          riwayat[_selectedRiwayat],
        ],
      ),
    );
  }
}
