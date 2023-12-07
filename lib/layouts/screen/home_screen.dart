import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/akun_screen.dart';
import 'package:official_sumbermaron/layouts/screen/riwayat_screen.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedScreen = 0;

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
      appBar: AppBar(
        title: Hero(
            tag: 'logo-app',
            child: Image.asset('assets/images/appbar.png', fit: BoxFit.cover)),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.app), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tickets), label: 'Riwayat'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'Akun'),
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

  int _current = 0;
  final CarouselController _controllerBanner = CarouselController();

  @override
  Widget build(BuildContext context) {
    List<String> imagesBanner = [
      "https://app.sumbermaron.site/5Kposting/sumbermaron.png",
      "https://app.sumbermaron.site/5Kposting/sumbermaron2.jpg",
      "https://app.sumbermaron.site/5Kposting/sumbermaron3.jpeg"
    ];
    List<String> imagesPromo = [
      "https://app.sumbermaron.site/5Kposting/promo.png",
      "https://app.sumbermaron.site/5Kposting/promo.png"
    ];

    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getHeight(10)),
            CarouselSlider(
              items: imagesBanner
                  .map(
                    (linkImage) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.network(
                            linkImage,
                            fit: BoxFit.cover,
                            width: 1000,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    kBlackColor,
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              carouselController: _controllerBanner,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 0.75,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            SizedBox(height: getHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagesBanner.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controllerBanner.animateToPage(entry.key),
                  child: Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_current == entry.key
                                ? kPrimaryColor
                                : kSecondaryColor)
                            .withOpacity(_current == entry.key ? 1 : .2)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: getHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: getWidth(35),
                        backgroundColor: kSecondaryColor,
                        child: Icon(
                          CupertinoIcons.ticket,
                          color: kWhiteColor,
                          size: getWidth(35),
                        ),
                      ),
                      SizedBox(height: getHeight(5)),
                      Text(
                        'Pesan Tiket',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(width: getWidth(70)),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: getWidth(35),
                        backgroundColor: kOrangeColor,
                        child: Icon(
                          CupertinoIcons.map,
                          color: kWhiteColor,
                          size: getWidth(35),
                        ),
                      ),
                      SizedBox(height: getHeight(5)),
                      Text(
                        'Jalur Lokasi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(20)),
            Container(
              height: getHeight(20),
              width: double.infinity,
              color: kGreyColor.withOpacity(.15),
            ),
            SizedBox(height: getHeight(20)),
            Text(
              'Info dan Promo Spesial',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: getHeight(10)),
            CarouselSlider(
              items: imagesPromo
                  .map(
                    (linkImage) => Container(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          linkImage,
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 1,
                enlargeCenterPage: true,
              ),
            ),
            SizedBox(height: getHeight(20)),
            Container(
              height: getHeight(20),
              width: double.infinity,
              color: kGreyColor.withOpacity(.15),
            ),
            SizedBox(height: getHeight(20)),
            Text(
              'Lokasi Sumber Maron',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: getHeight(10)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
              child: InkWell(
                onTap: _openGoogleMaps,
                child: Container(
                  height: getHeight(200),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/smmap.jpeg')),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: kSecondaryColor.withOpacity(.2),
                        blurRadius: 1,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }
}
