import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/jalur_lokasi.dart';
import 'package:sumbermaron/layouts/partials/pesan_tiket.dart';
import 'package:sumbermaron/layouts/screens/akun_screen.dart';
import 'package:sumbermaron/layouts/screens/riwayat_screen.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

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
    var _pilihScreen = widget.pilihScreen;
    if (_pilihScreen != null) {
      _onTapNavbar(_pilihScreen);
    }
    super.initState();
  }

  void _onTapNavbar(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  List<Widget> screen = [
    BerandaScreen(),
    RiwayatScreen(),
    AkunScreen(),
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
                label: 'Riwayat'),
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
  final Uri _url = Uri.parse('https://maps.app.goo.gl/t7pb991Fm7BkNXhb8');
  Future<void> _openGoogleMaps() async {
    if (!await launchUrl(_url)) {
      throw Exception('Tidak dapat membuka Google Maps');
    }
  }

  int _currentBanner = 0;
  final CarouselController _controllerBanner = CarouselController();

  @override
  Widget build(BuildContext context) {
    List<dynamic> dataBanner = muatBanner();

    return Scaffold(
        body: Expanded(
      child: Column(children: [
        SizedBox(
            height: getHeight(300),
            child: Stack(alignment: Alignment.topCenter, children: [
              Container(
                height: getHeight(235),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom:
                            Radius.elliptical(getHeight(200), getHeight(50))),
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg_sumbermaron.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            kPrimaryColor.withOpacity(.8),
                            BlendMode.multiply))),
              ),
              Positioned(
                  top: getHeight(90),
                  child: Image.asset('assets/images/smlogo_horizontal.png',
                      height: getHeight(30))),
              Positioned(
                  top: getHeight(155),
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const PesanTiket()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(getHeight(20)),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: kGreyColor.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: getHeight(30),
                                backgroundColor: kSecondaryColor,
                                child: Icon(
                                  CupertinoIcons.ticket_fill,
                                  color: kWhiteColor,
                                  size: getHeight(30),
                                ),
                              ),
                              SizedBox(height: getHeight(10)),
                              Text('Pesan Tiket')
                            ],
                          )),
                    ),
                    SizedBox(width: getWidth(30)),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const JalurLokasi()));
                        },
                        child: Container(
                            padding: EdgeInsets.all(getHeight(20)),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: kGreyColor.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(children: [
                              CircleAvatar(
                                radius: getHeight(30),
                                backgroundColor: kSecondaryColor,
                                child: Icon(
                                  CupertinoIcons.map_fill,
                                  color: kWhiteColor,
                                  size: getHeight(30),
                                ),
                              ),
                              SizedBox(height: getHeight(10)),
                              Text('Lokasi Parkir')
                            ]))),
                  ]))
            ])),
        Container(
            margin: EdgeInsets.symmetric(vertical: getHeight(20)),
            height: getHeight(20),
            color: kGreyColor.withOpacity(.2)),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: getHeight(10)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  alignment: Alignment.centerLeft,
                  child: Text('Info dan Promo Spesial',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              CarouselSlider(
                items: dataBanner
                    .map((banner) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: getWidth(5)),
                          child: GestureDetector(
                            onTap: (banner['tipeBanner'] == 'Promo')
                                ? () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => PesanTiket(
                                                  namaPromo:
                                                      banner['namaPromo'],
                                                  promoTiket:
                                                      banner['promoTiket'],
                                                  tiketMinimal:
                                                      banner['tiketMinimal'],
                                                )));
                                  }
                                : null,
                            child: ClipRRect(
                                child: CachedNetworkImage(
                                    imageUrl:
                                        'https://app.sumbermaron.site/5Kposting/${banner['imageBanner']}')),
                          ),
                        ))
                    .toList(),
                carouselController: _controllerBanner,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.1,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentBanner = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: dataBanner.asMap().entries.map((entry) {
                  return GestureDetector(
                      onTap: () => _controllerBanner.animateToPage(entry.key),
                      child: Container(
                          width: _currentBanner == entry.key ? 20 : 10,
                          height: 10,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(
                                  _currentBanner == entry.key ? 0.9 : 0.2),
                              borderRadius: BorderRadius.circular(10))));
                }).toList(),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: getHeight(20)),
                  height: getHeight(20),
                  color: kGreyColor.withOpacity(.2)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                  alignment: Alignment.centerLeft,
                  child: Text('Lokasi Sumber Maron',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: getHeight(15)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                child: GestureDetector(
                  onTap: _openGoogleMaps,
                  child: Container(
                    height: getHeight(200),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/smpeta.jpg')),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kGreyColor.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: getHeight(30))
            ],
          ),
        ))
      ]),
    ));
  }
}
