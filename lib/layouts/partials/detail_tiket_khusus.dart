import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sumbermaron_admin/layouts/partials/edit_tiket.dart';
import 'package:sumbermaron_admin/layouts/partials/reschedule_tiket.dart';
import 'package:sumbermaron_admin/layouts/partials/tiket_khusus.dart';
import 'package:sumbermaron_admin/layouts/screens/scanqr_screen.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/secure_http.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class DetailTiketKhusus extends StatefulWidget {
  const DetailTiketKhusus({
    Key? key,
    required this.dataTiket,
  }) : super(key: key);

  final Map<String, dynamic> dataTiket;

  @override
  State<DetailTiketKhusus> createState() => _DetailTiketKhususState();
}

class _DetailTiketKhususState extends State<DetailTiketKhusus> {
  HttpApi dataResponse = HttpApi();

  String tanggalSekarang = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var idTiket = widget.dataTiket['idTiket'] ?? '';
    var nama = widget.dataTiket['namaUser'] ?? '';
    var jumlahPengunjung = widget.dataTiket['jumlahPengunjung'] ?? '';
    var jumlahTiket = widget.dataTiket['jumlahTiket'] ?? '';
    var totalBayar = widget.dataTiket['totalBayar'] ?? '';
    var tanggalBooking = widget.dataTiket['tanggalBooking'] ?? '';
    var statusBayar = widget.dataTiket['statusBayar'] ?? '';
    var kodeEt = widget.dataTiket['kodeEt'] ?? '';

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
        backgroundColor: kPrimaryColor,
        title: const Text('Detail Tiket Khusus',
            style: TextStyle(color: kWhiteColor)),
        centerTitle: true,
        actionsIconTheme: const IconThemeData(color: kWhiteColor),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.calendar_today,
                            color: kBlackColor),
                        SizedBox(width: getWidth(10)),
                        const Text('Reschedule Tiket')
                      ],
                    )),
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        const Icon(Icons.edit, color: kBlackColor),
                        SizedBox(width: getWidth(10)),
                        const Text('Edit Tiket')
                      ],
                    )),
                PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.trash, color: kRedColor),
                        SizedBox(width: getWidth(10)),
                        const Text('Hapus Tiket',
                            style: TextStyle(color: kRedColor))
                      ],
                    ))
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RescheduleTiket(dataTiket: widget.dataTiket)));
              } else if (value == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        EditTiket(dataTiket: widget.dataTiket)));
              } else if (value == 2) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: getHeight(10)),
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text('Hapus tiket khusus?',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(
                              'Hapus',
                              style: TextStyle(
                                  color: kRedColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              HttpApi.hapusTiket(widget.dataTiket['idTiket'])
                                  .then((value) {
                                dataResponse = value;
                                if (dataResponse.textMessage ==
                                    'Hapus tiket khusus berhasil') {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TiketKhusus()));
                                }
                              });
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text(
                              'Batalkan',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                          vertical: getHeight(2), horizontal: getWidth(10)),
                      decoration: BoxDecoration(
                          color:
                              statusBorderColor[statusBayar].withOpacity(.15),
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
                        Text(kodeEt,
                            style: const TextStyle(
                                color: kGreyColor, fontSize: sizeDescription)),
                        SizedBox(height: getHeight(15)),
                        const Text('Nama Pemesan',
                            style: TextStyle(color: kGreyColor)),
                        SizedBox(height: getHeight(3)),
                        Text(nama,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: getHeight(15)),
                        const Text('Tanggal',
                            style: TextStyle(color: kGreyColor)),
                        SizedBox(height: getHeight(3)),
                        Text(formatTanggalIndonesia(tanggalBooking),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: getHeight(15)),
                        const Text('Jam Operasional',
                            style: TextStyle(color: kGreyColor)),
                        SizedBox(height: getHeight(3)),
                        const Text('08:00 - 17:00 WIB',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: getHeight(15)),
                  Container(height: 1, color: kPrimaryColor.withOpacity(.5)),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Jumlah Tiket',
                              style: TextStyle(color: kGreyColor)),
                          SizedBox(height: getHeight(3)),
                          Text('$jumlahTiket Tiket',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: getHeight(15)),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: getHeight(5)),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: kPrimaryColor.withOpacity(.5))),
                      child: Column(children: [
                        const Text('Total Harga'),
                        SizedBox(height: getHeight(5)),
                        Text(formatRupiah(totalBayar),
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: sizeTitle,
                                fontWeight: FontWeight.bold))
                      ])),
                  SizedBox(height: getHeight(20)),
                ],
              ),
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: getHeight(120),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        margin: EdgeInsets.only(bottom: getHeight(30)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: getHeight(50),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: tanggalSekarang == tanggalBooking
                    ? () {
                        terimaPembayaran(context, idTiket, 'Tunai');
                      }
                    : null,
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: const Text(
                  'Terima Pembayaran Tunai',
                  style: TextStyle(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
            Container(
              width: double.infinity,
              height: getHeight(50),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: tanggalSekarang == tanggalBooking
                    ? () {
                        terimaPembayaran(context, idTiket, 'QRIS');
                      }
                    : null,
                style: OutlinedButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    side: BorderSide(
                        color: tanggalSekarang == tanggalBooking
                            ? kPrimaryColor
                            : kGreyColor)),
                child: Text(
                  'Terima Pembayaran QRIS',
                  style: TextStyle(
                      color: tanggalSekarang == tanggalBooking
                          ? kPrimaryColor
                          : kGreyColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void terimaPembayaran(
      BuildContext context, String idTiket, String jenisPembayaran) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: getHeight(10)),
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(20)),
              child: Text('Pembayaran $jenisPembayaran?',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            content: Column(children: [
              SizedBox(height: getHeight(10)),
              Text(
                  'Menerima uang pembayaran tiket berupa $jenisPembayaran dari Pengunjung.')
            ]),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Terima $jenisPembayaran',
                  style: const TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  HttpApi.tukarTiket(idTiket, jenisPembayaran).then((value) {
                    dataResponse = value;
                    if (dataResponse.textMessage ==
                        'Penukaran tiket diterima') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ScanQRScreen()));
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: getHeight(10)),
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text('Tiket diterima',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text(
                                    'Tutup',
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  }).catchError((error) {
                    cekInternet(context);
                  });
                },
              ),
              CupertinoDialogAction(
                child: const Text(
                  'Batalkan',
                  style:
                      TextStyle(color: kRedColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
