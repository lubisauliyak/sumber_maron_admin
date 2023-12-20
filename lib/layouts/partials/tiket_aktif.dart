import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/detail_tiket_aktif.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/choice_config.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class TiketAktif extends StatefulWidget {
  const TiketAktif({super.key});

  @override
  State<TiketAktif> createState() => _TiketAktifState();
}

class _TiketAktifState extends State<TiketAktif> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataTiketAktif = [];
  bool isEmptyTiketAktif = true;

  String textMessage = 'Sedang mencari tiket aktif Anda';

  @override
  void initState() {
    var data = muatTiketAktif();
    if (data.isEmpty) {
      setState(() {
        isEmptyTiketAktif = true;
        textMessage = 'Tiket aktif belum ada';
      });
    } else {
      setState(() {
        dataTiketAktif = data;
        isEmptyTiketAktif = false;
      });
    }
    HttpApi.tiketAktif().then((value) {
      dataResponse = value;
      if (dataResponse.textMessage == 'Data tiket aktif ditemukan') {
        setState(() {
          data = muatTiketAktif();
          dataTiketAktif = data;
          isEmptyTiketAktif = false;
        });
      } else if (dataResponse.textMessage == 'Data tiket aktif belum ada') {
        setState(() {
          isEmptyTiketAktif = true;
          textMessage = 'Tiket aktif belum ada';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isEmptyTiketAktif)
        ? Column(
            children: [
              SizedBox(height: getHeight(30)),
              Icon(CupertinoIcons.slash_circle),
              SizedBox(height: getHeight(10)),
              Text(textMessage),
            ],
          )
        : Column(
            children: [
              ...dataTiketAktif.map((tiketAktif) {
                return TiketAktifItem(dataTiket: tiketAktif);
              }).toList(),
            ],
          );
  }
}

class TiketAktifItem extends StatelessWidget {
  const TiketAktifItem({super.key, required this.dataTiket});

  final Map<String, dynamic> dataTiket;

  @override
  Widget build(BuildContext context) {
    var jumlahPengunjung = dataTiket['jumlahPengunjung'];
    var totalBayar = dataTiket['totalBayar'];
    var tanggalBooking = dataTiket['tanggalBooking'];
    var statusBayar = dataTiket['statusBayar'];

    return Container(
      margin: EdgeInsets.only(top: getHeight(5), bottom: getHeight(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DetailTiketAktif(dataTiket: dataTiket)));
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
                  color: statusBorderColor[statusBayar].withOpacity(.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0))
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
                        formatTanggalIndonesia(tanggalBooking),
                        style: TextStyle(fontSize: 11),
                      )
                    ],
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
                      Text('Jumlah Pengunjung:'),
                      SizedBox(height: getHeight(5)),
                      Text(
                        '$jumlahPengunjung Orang',
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Total Bayar:'),
                      SizedBox(height: getHeight(5)),
                      Text(
                        formatRupiah(totalBayar),
                        style: TextStyle(
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
