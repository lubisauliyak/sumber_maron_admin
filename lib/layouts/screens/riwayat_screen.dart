import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_tiket_masuk.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataTiketMasuk = [];
  bool isEmptyTiketMasuk = false;

  String textMessage = 'Sedang mencari tiket masuk hari ini';

  @override
  void initState() {
    var data = muatTiketMasuk();
    if (data.isEmpty) {
      setState(() {
        isEmptyTiketMasuk = true;
        textMessage = 'Tiket masuk hari ini belum ada';
      });
    } else {
      setState(() {
        dataTiketMasuk = data;
        isEmptyTiketMasuk = false;
      });
    }
    HttpApi.dataTiketMasuk().then((value) {
      dataResponse = value;
      if (dataResponse.textMessage == 'Data tiket masuk ditemukan') {
        data = muatTiketMasuk();
        setState(() {
          dataTiketMasuk = data;
          isEmptyTiketMasuk = false;
        });
      } else if (dataResponse.textMessage ==
          'Data tiket masuk hari ini belum ada') {
        setState(() {
          isEmptyTiketMasuk = true;
          textMessage = 'Tiket masuk hari ini belum ada';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tanggalSekarang =
        formatTanggalIndonesia(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('Tiket Masuk', style: TextStyle(color: kWhiteColor)),
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: getHeight(20)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                child: Text(tanggalSekarang,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: getHeight(20)),
              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: (isEmptyTiketMasuk)
                          ? Column(
                              children: [
                                SizedBox(height: getHeight(30)),
                                const Icon(CupertinoIcons.slash_circle),
                                SizedBox(height: getHeight(10)),
                                Text(textMessage),
                              ],
                            )
                          : Column(
                              children: [
                                ...dataTiketMasuk.map((tiketMasuk) {
                                  return TiketMasukItem(dataTiket: tiketMasuk);
                                }).toList(),
                              ],
                            ))),
            ],
          ),
        ));
  }
}

class TiketMasukItem extends StatelessWidget {
  const TiketMasukItem({super.key, required this.dataTiket});

  final Map<String, dynamic> dataTiket;

  @override
  Widget build(BuildContext context) {
    var jumlahPengunjung = dataTiket['jumlahPengunjung'];
    var totalBayar = dataTiket['totalBayar'];
    var waktuTiket = dataTiket['waktuTiket'];
    var kategoriTiket = dataTiket['kategoriTiket'];

    return Container(
      margin: EdgeInsets.only(top: getHeight(5), bottom: getHeight(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailTiketMasuk(dataTiket: dataTiket)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
          margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
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
            children: [
              SizedBox(height: getHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/smlogo_tiket.png',
                        height: getWidth(20),
                      ),
                      Text(
                        'Kedatangan ${formatWIB(waktuTiket)}',
                        style: const TextStyle(fontSize: sizeDescription),
                      )
                    ],
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
              SizedBox(height: getHeight(15)),
              Container(
                height: 1,
                width: double.infinity,
                color: kGreyColor,
              ),
              SizedBox(height: getHeight(15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Jumlah Pengunjung:'),
                      SizedBox(height: getHeight(5)),
                      Text(
                        '$jumlahPengunjung Orang',
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Total Bayar:'),
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
        ),
      ),
    );
  }
}
