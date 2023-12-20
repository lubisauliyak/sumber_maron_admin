import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/detail_riwayat_tiket.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/choice_config.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class RiwayatTiket extends StatefulWidget {
  const RiwayatTiket({super.key});

  @override
  State<RiwayatTiket> createState() => _RiwayatTiketState();
}

class _RiwayatTiketState extends State<RiwayatTiket> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataRiwayatTiket = [];
  bool isEmptyRiwayatTiket = true;

  String textMessage = 'Sedang mencari riwayat tiket Anda';

  @override
  void initState() {
    var data = muatRiwayatTiket();
    if (data.isEmpty) {
      setState(() {
        isEmptyRiwayatTiket = true;
        textMessage = 'Riwayat tiket belum ada';
      });
    } else {
      setState(() {
        dataRiwayatTiket = data;
        isEmptyRiwayatTiket = false;
      });
    }
    HttpApi.riwayatTiket().then((value) {
      dataResponse = value;
      if (dataResponse.textMessage == 'Data riwayat tiket ditemukan') {
        setState(() {
          data = muatRiwayatTiket();
          dataRiwayatTiket = data;
          isEmptyRiwayatTiket = false;
        });
      } else if (dataResponse.textMessage == 'Data riwayat tiket belum ada') {
        setState(() {
          isEmptyRiwayatTiket = true;
          textMessage = 'Riwayat tiket belum ada';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isEmptyRiwayatTiket)
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
              ...dataRiwayatTiket.map((riwayatTiket) {
                return RiwayatTiketItem(
                  dataTiket: riwayatTiket,
                );
              }).toList(),
            ],
          );
  }
}

class RiwayatTiketItem extends StatelessWidget {
  const RiwayatTiketItem({super.key, required this.dataTiket});

  final Map<String, dynamic> dataTiket;

  @override
  Widget build(BuildContext context) {
    var jumlahPengunjung = dataTiket['jumlahPengunjung'];
    var totalBayar = dataTiket['totalBayar'];
    var tanggalBooking = dataTiket['tanggalBooking'];
    var statusBayar = dataTiket['statusBayar'];

    return Column(children: [
      SizedBox(height: getHeight(5)),
      Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
            horizontal: getWidth(30), vertical: getHeight(15)),
        decoration: BoxDecoration(
            color: kGreyColor.withOpacity(.2),
            border: Border(top: BorderSide(color: kGreyColor.withOpacity(.5)))),
        child: Text(formatTanggalIndonesia(tanggalBooking)),
      ),
      SizedBox(height: getHeight(20)),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DetailRiwayatTiket(dataTiket: dataTiket)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(15)),
          margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: (kGreyColor.withOpacity(.5))),
          ),
          child: Column(
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
                        color: statusBorderColor[statusBayar].withOpacity(.15),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(statusBayar,
                        style: TextStyle(
                            color: statusTextColor[statusBayar],
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
      SizedBox(height: getHeight(25))
    ]);
  }
}
