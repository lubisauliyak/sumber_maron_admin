import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_tiket_khusus.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class TiketKhusus extends StatefulWidget {
  const TiketKhusus({super.key});

  @override
  State<TiketKhusus> createState() => _TiketKhususState();
}

class _TiketKhususState extends State<TiketKhusus> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataTiketKhusus = [];
  bool isEmptyTiketKhusus = false;

  String textMessage = 'Sedang mencari tiket khusus';

  @override
  void initState() {
    var data = muatTiketKhusus();
    if (data.isEmpty) {
      setState(() {
        isEmptyTiketKhusus = true;
        textMessage = 'Tiket khusus belum ada';
      });
    } else {
      setState(() {
        dataTiketKhusus = data;
        isEmptyTiketKhusus = false;
      });
    }
    HttpApi.dataTiketKhusus().then((value) {
      dataResponse = value;
      if (dataResponse.textMessage == 'Data tiket khusus ditemukan') {
        data = muatTiketKhusus();
        setState(() {
          dataTiketKhusus = data;
          isEmptyTiketKhusus = false;
        });
      } else if (dataResponse.textMessage == 'Data tiket khusus belum ada') {
        setState(() {
          isEmptyTiketKhusus = true;
          textMessage = 'Tiket khusus belum ada';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
          'Tiket Khusus',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: getHeight(30)),
            (isEmptyTiketKhusus)
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Column(
                      children: [
                        SizedBox(height: getHeight(30)),
                        const Icon(CupertinoIcons.slash_circle),
                        SizedBox(height: getHeight(10)),
                        Text(textMessage),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      ...dataTiketKhusus.map((tiketMasuk) {
                        return TiketKhususItem(dataTiket: tiketMasuk);
                      }).toList(),
                    ],
                  ),
            SizedBox(height: getHeight(30)),
          ],
        ),
      )),
    );
  }
}

class TiketKhususItem extends StatelessWidget {
  const TiketKhususItem({super.key, required this.dataTiket});

  final Map<String, dynamic> dataTiket;

  @override
  Widget build(BuildContext context) {
    var namaUser = dataTiket['namaUser'];
    var teleponUser = dataTiket['teleponUser'];
    var jumlahPengunjung = dataTiket['jumlahPengunjung'];
    var totalBayar = dataTiket['totalBayar'];
    var tanggalBooking = dataTiket['tanggalBooking'];

    return Container(
      margin: EdgeInsets.only(top: getHeight(5), bottom: getHeight(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailTiketKhusus(dataTiket: dataTiket)));
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
                        formatTanggalIndonesia(tanggalBooking),
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
                    child: const Text('Tiket Khusus',
                        style: TextStyle(
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
                      const Text('Nama:'),
                      SizedBox(height: getHeight(5)),
                      Text(
                        namaUser,
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Telepon:'),
                      SizedBox(height: getHeight(5)),
                      Text(
                        teleponUser,
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
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
