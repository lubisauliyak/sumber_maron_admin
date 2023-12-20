import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class JalurLokasi extends StatefulWidget {
  const JalurLokasi({super.key});

  @override
  State<JalurLokasi> createState() => _JalurLokasiState();
}

class _JalurLokasiState extends State<JalurLokasi> {
  Future<void> _openGoogleMaps(String urlMaps) async {
    final Uri url = Uri.parse(urlMaps);
    if (!await launchUrl(url)) {
      throw Exception('Tidak dapat membuka Google Maps');
    }
  }

  final Map<String, dynamic> dataLokasiParkir = muatLokasiParkir();

  late List<dynamic> parkirBus = dataLokasiParkir['parkirBus'];
  late List<dynamic> parkirMobil = dataLokasiParkir['parkirMobil'];
  late List<dynamic> parkirMotor = dataLokasiParkir['parkirMotor'];

  var isBus = true;
  var isCar = false;
  var isMotor = false;

  String? tipeKendaraan;
  List<dynamic>? dataParkir;
  int? _pilihJalur;
  String? _linkMaps;
  String? _imageMaps;

  @override
  void initState() {
    tipeKendaraan = 'Bus';
    _pilihJalur = 0;
    dataParkir = parkirBus;
    _linkMaps = dataParkir?[_pilihJalur ?? 0]['linkMaps'];
    _imageMaps = dataParkir?[_pilihJalur ?? 0]['imageMaps'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
          'Info Lokasi Parkir',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: getHeight(30)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pilih Transaportasi'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBus = true;
                          isCar = false;
                          isMotor = false;

                          tipeKendaraan = 'Bus';
                          dataParkir = parkirBus;
                          _pilihJalur = 0;
                          _linkMaps = dataParkir?[_pilihJalur ?? 0]['linkMaps'];
                          _imageMaps =
                              dataParkir?[_pilihJalur ?? 0]['imageMaps'];
                        });
                      },
                      child: SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            Icon(
                                isBus
                                    ? Icons.directions_bus_filled
                                    : Icons.directions_bus,
                                color: isBus ? kPrimaryColor : kGreyColor,
                                size: 20),
                            Text('Bus',
                                style: TextStyle(
                                    color: isBus ? kPrimaryColor : kGreyColor,
                                    fontSize: sizeDescription))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: getWidth(10)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBus = false;
                          isCar = true;
                          isMotor = false;

                          tipeKendaraan = 'Mobil';
                          dataParkir = parkirMobil;
                          _pilihJalur = 0;
                          _linkMaps = dataParkir?[_pilihJalur ?? 0]['linkMaps'];
                          _imageMaps =
                              dataParkir?[_pilihJalur ?? 0]['imageMaps'];
                        });
                      },
                      child: SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            Icon(
                                isCar
                                    ? Icons.directions_car_filled
                                    : Icons.directions_car,
                                color: isCar ? kPrimaryColor : kGreyColor,
                                size: 20),
                            Text('Mobil',
                                style: TextStyle(
                                    color: isCar ? kPrimaryColor : kGreyColor,
                                    fontSize: sizeDescription))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: getWidth(10)),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBus = false;
                          isCar = false;
                          isMotor = true;

                          tipeKendaraan = 'Motor';
                          dataParkir = parkirMotor;
                          _pilihJalur = 0;
                          _linkMaps = dataParkir?[_pilihJalur ?? 0]['linkMaps'];
                          _imageMaps =
                              dataParkir?[_pilihJalur ?? 0]['imageMaps'];
                        });
                      },
                      child: SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            Icon(
                                isMotor
                                    ? Icons.motorcycle_rounded
                                    : Icons.motorcycle,
                                color: isMotor ? kPrimaryColor : kGreyColor,
                                size: 20),
                            Text('Motor',
                                style: TextStyle(
                                    color: isMotor ? kPrimaryColor : kGreyColor,
                                    fontSize: sizeDescription))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: getHeight(50)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: getWidth(30)),
            child: DropdownButtonFormField<int>(
              value: _pilihJalur,
              onChanged: (int? newValue) {
                setState(() {
                  _pilihJalur = newValue;
                  _linkMaps = dataParkir?[_pilihJalur ?? 0]['linkMaps'];
                  _imageMaps = dataParkir?[_pilihJalur ?? 0]['imageMaps'];
                });
              },
              items: [
                if (dataParkir != null)
                  ...dataParkir!.asMap().entries.map((entry) {
                    final index = entry.key;
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text('Parkir $tipeKendaraan ${index + 1}'),
                    );
                  }),
              ],
              decoration:
                  InputDecoration(labelText: 'Pilih Jalur $tipeKendaraan'),
            ),
          ),
          SizedBox(height: getHeight(20)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
            child: GestureDetector(
              onTap: () {
                if (_linkMaps != null) {
                  _openGoogleMaps(
                      _linkMaps ?? 'https://maps.app.goo.gl/t7pb991Fm7BkNXhb8');
                }
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          'https://app.sumbermaron.site/5Kposting/${_imageMaps ?? 'images/parkir_bus1.jpg'}')),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kGreyColor.withOpacity(.2),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
