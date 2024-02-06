// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sumbermaron_admin/layouts/partials/tiket_khusus.dart';
import 'package:sumbermaron_admin/layouts/partials/tiket_konvensional.dart';
import 'package:sumbermaron_admin/layouts/screens/akun_screen.dart';
import 'package:sumbermaron_admin/layouts/screens/riwayat_screen.dart';
import 'package:sumbermaron_admin/layouts/screens/scanqr_screen.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class MainScreen extends StatefulWidget {
  final int? pilihScreen;
  const MainScreen({
    Key? key,
    this.pilihScreen,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedScreen = 0;

  @override
  void initState() {
    if (widget.pilihScreen != null && widget.pilihScreen != 0) {
      _onTapNavbar(widget.pilihScreen ?? 0);
    }
    super.initState();
  }

  void _onTapNavbar(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  List<Widget> screen = [
    const BerandaScreen(),
    const RiwayatScreen(),
    const AkunScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          selectedFontSize: 14,
          backgroundColor: kWhiteColor,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kBlackColor,
          onTap: _onTapNavbar,
          currentIndex: _selectedScreen,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedScreen == 0 ? Icons.home : Icons.home_outlined),
                label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(_selectedScreen == 1
                    ? CupertinoIcons.tickets_fill
                    : CupertinoIcons.tickets),
                label: 'Tiket'),
            BottomNavigationBarItem(
                icon: Icon(_selectedScreen == 2
                    ? CupertinoIcons.person_fill
                    : CupertinoIcons.person),
                label: 'Akun'),
          ]),
    );
  }
}

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataSummary = muatSummary();

  int _currentBanner = 0;
  final CarouselController _controllerSummary = CarouselController();

  @override
  void initState() {
    HttpApi.dataSummaryTiket();
    setState(() {
      dataSummary = muatSummary();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
      child: Column(children: [
        SizedBox(
            height: getHeight(250),
            child: Stack(alignment: Alignment.topCenter, children: [
              Container(
                height: getHeight(240),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom:
                            Radius.elliptical(getHeight(250), getHeight(50))),
                    image: DecorationImage(
                        image: const AssetImage(
                            'assets/images/bg_sumbermaron.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            kPrimaryColor.withOpacity(.8),
                            BlendMode.multiply))),
              ),
              Positioned(
                  top: getHeight(100),
                  child: Image.asset('assets/images/smlogo_horizontal.png',
                      height: getHeight(30))),
            ])),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: getHeight(10)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScanQRScreen()));
                },
                child: Container(
                    width: getWidth(250),
                    padding: EdgeInsets.symmetric(
                        vertical: getHeight(10), horizontal: getWidth(20)),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kGreyColor.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: getHeight(25),
                          backgroundColor: kWhiteColor,
                          child: Icon(
                            CupertinoIcons.qrcode_viewfinder,
                            color: kPrimaryColor,
                            size: getHeight(25),
                          ),
                        ),
                        SizedBox(width: getWidth(20)),
                        const Text('Scan Tiket',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
              ),
              SizedBox(height: getHeight(20)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TiketKonvensional()));
                },
                child: Container(
                    width: getWidth(250),
                    padding: EdgeInsets.symmetric(
                        vertical: getHeight(10), horizontal: getWidth(20)),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: getHeight(25),
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            CupertinoIcons.tickets,
                            color: kWhiteColor,
                            size: getHeight(25),
                          ),
                        ),
                        SizedBox(width: getWidth(20)),
                        const Text('Tiket Konvensional',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
              ),
              SizedBox(height: getHeight(20)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TiketKhusus()));
                },
                child: Container(
                    width: getWidth(250),
                    padding: EdgeInsets.symmetric(
                        vertical: getHeight(10), horizontal: getWidth(20)),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: getHeight(25),
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            CupertinoIcons.staroflife,
                            color: kWhiteColor,
                            size: getHeight(25),
                          ),
                        ),
                        SizedBox(width: getWidth(20)),
                        const Text('Tiket Khusus',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold))
                      ],
                    )),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: getHeight(20)),
                  height: getHeight(20),
                  color: kGreyColor.withOpacity(.2)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  alignment: Alignment.centerLeft,
                  child: const Text('Informasi Penjualan',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: getHeight(10)),
              CarouselSlider(
                items: dataSummary
                    .map((summary) => buildSummaryData(summary))
                    .toList(),
                carouselController: _controllerSummary,
                options: CarouselOptions(
                  aspectRatio: 2.5,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentBanner = index;
                    });
                  },
                ),
              ),
              SizedBox(height: getHeight(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dataSummary.asMap().entries.map((entry) {
                  return GestureDetector(
                      onTap: () => _controllerSummary.animateToPage(entry.key),
                      child: Container(
                          width: _currentBanner == entry.key ? 20 : 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(
                                  _currentBanner == entry.key ? 0.9 : 0.2),
                              borderRadius: BorderRadius.circular(10))));
                }).toList(),
              ),
              SizedBox(height: getHeight(20)),
            ],
          ),
        )),
      ]),
    ));
  }

  Widget buildSummaryData(Map<String, dynamic> summary) {
    var kategoriTiket = summary['label'].toString();
    var jumlahTiket = summary['tiket'].toString();
    var totalBayar = summary['totalBayar'].toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
      margin: EdgeInsets.symmetric(
          vertical: getHeight(5), horizontal: getWidth(10)),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (kGreyColor.withOpacity(.2))),
        boxShadow: [
          BoxShadow(
              color: kPrimaryColor.withOpacity(.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: getHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/smlogo_tiket.png',
                height: getWidth(20),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: getHeight(2), horizontal: getWidth(10)),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(.15),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(kategoriTiket,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: sizeDescription)),
              ),
            ],
          ),
          SizedBox(height: getHeight(10)),
          Container(
            height: 1,
            width: double.infinity,
            color: kGreyColor,
          ),
          SizedBox(height: getHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tiket:'),
                  SizedBox(height: getHeight(5)),
                  Text('$jumlahTiket Tiket',
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Penjualan:'),
                  SizedBox(height: getHeight(5)),
                  Text(
                    formatRupiah(totalBayar),
                    style: const TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: getHeight(20)),
        ],
      ),
    );
  }
}
