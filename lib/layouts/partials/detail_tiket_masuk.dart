import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class DetailTiketMasuk extends StatelessWidget {
  const DetailTiketMasuk({
    Key? key,
    required this.dataTiket,
  }) : super(key: key);

  final Map<String, dynamic> dataTiket;

  @override
  Widget build(BuildContext context) {
    var kategoriTiket = dataTiket['kategoriTiket'];
    var namaAdmin = dataTiket['namaAdmin'];
    var namaUser = dataTiket['namaUser'];
    var tanggalTiket = dataTiket['tanggalTiket'];
    var waktuTiket = dataTiket['waktuTiket'];
    var jumlahPengunjung = dataTiket['jumlahPengunjung'];
    var jumlahTiket = dataTiket['jumlahTiket'];
    var totalBayar = dataTiket['totalBayar'];
    var metodeBayar = dataTiket['metodeBayar'];
    var statusBayar = dataTiket['statusBayar'];
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
          'Detail Tiket Masuk',
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
            SizedBox(
              height: getHeight(650),
              child: Column(
                children: [
                  SizedBox(height: getHeight(20)),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/smlogo_tiket.png',
                              height: getWidth(20)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: getHeight(2),
                                horizontal: getWidth(10)),
                            decoration: BoxDecoration(
                                color: statusBorderColor[statusBayar]
                                    .withOpacity(.15),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(statusBayar,
                                style: TextStyle(
                                    color: statusTextColor[statusBayar],
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizeDescription)),
                          ),
                        ],
                      )),
                  SizedBox(height: getHeight(20)),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      border: Border.all(color: kGreyColor.withOpacity(.2)),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: kGreyColor.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: getHeight(20)),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tiket Wisata Sumber Maron',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              kategoriTiket != 'Tiket Konvensional'
                                  ? Text(dataTiket['kodeEt'],
                                      style: const TextStyle(
                                          color: kGreyColor,
                                          fontSize: sizeDescription))
                                  : SizedBox(height: getHeight(0)),
                              SizedBox(height: getHeight(15)),
                              const Text('Nama Pengunjung',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              Text(namaUser,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: getHeight(15)),
                              const Text('Loket',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              Text(namaAdmin,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: getHeight(15)),
                              const Text('Tanggal',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              Text(formatTanggalIndonesia(tanggalTiket),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: getHeight(15)),
                              const Text('Waktu Kedatangan',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              Text(formatWIB(waktuTiket),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: getHeight(15)),
                        Container(
                            height: 1, color: kPrimaryColor.withOpacity(.5)),
                        SizedBox(height: getHeight(15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Jumlah Pengunjung',
                                    style: TextStyle(color: kGreyColor)),
                                SizedBox(height: getHeight(3)),
                                Text('$jumlahPengunjung Orang',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Jumlah Tiket',
                                    style: TextStyle(color: kGreyColor)),
                                SizedBox(height: getHeight(3)),
                                Text('$jumlahTiket Tiket',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: getHeight(15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Bayar',
                                    style: TextStyle(color: kGreyColor)),
                                SizedBox(height: getHeight(3)),
                                Text(formatRupiah(totalBayar),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Jenis Pembayaran',
                                    style: TextStyle(color: kGreyColor)),
                                SizedBox(height: getHeight(3)),
                                Text(metodeBayar,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight(30))
          ],
        ),
      )),
    );
  }
}
