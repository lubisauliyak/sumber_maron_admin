import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sumbermaron/layouts/partials/snap_midtrans.dart';

import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/choice_config.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class DetailTiketAktif extends StatefulWidget {
  const DetailTiketAktif({
    Key? key,
    required this.dataTiket,
  }) : super(key: key);

  final Map<String, dynamic> dataTiket;

  @override
  State<DetailTiketAktif> createState() => _DetailTiketAktifState();
}

class _DetailTiketAktifState extends State<DetailTiketAktif> {
  HttpApi dataResponse = HttpApi();

  @override
  Widget build(BuildContext context) {
    var dataPengguna = muatAkun();

    var jumlahPengunjung = widget.dataTiket['jumlahPengunjung'];
    var jumlahTiket = widget.dataTiket['jumlahTiket'];
    var totalBayar = widget.dataTiket['totalBayar'];
    var tanggalPesan = widget.dataTiket['tanggalPesan'];
    var tanggalBooking = widget.dataTiket['tanggalBooking'];
    var metodeBayar = widget.dataTiket['metodeBayar'];
    var statusBayar = widget.dataTiket['statusBayar'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MainScreen(pilihScreen: 1)));
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
          'Tiket Aktif Pengunjung',
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
                  (metodeBayar == 'Non Tunai' &&
                          statusBayar == 'Menunggu Pembayaran')
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: kOrangeColor.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  const Icon(CupertinoIcons.stopwatch,
                                      color: kOrangeColor),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          'Selesaikan pembayaran sebelum',
                                          style: TextStyle(
                                              color: kOrangeColor,
                                              fontSize: sizeText)),
                                      Text(
                                        '00:00 ${formatTanggalIndonesia(DateFormat('yyyy-MM-dd').format(DateTime.parse(tanggalPesan).add(const Duration(days: 1))))}',
                                        style: const TextStyle(
                                            color: kOrangeColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total yang harus dibayar',
                                    style: TextStyle(color: kGreyColor)),
                                Text(formatRupiah(totalBayar),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(height: 1, color: kGreyColor),
                            const SizedBox(height: 15),
                            SizedBox(
                              // padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.device_phone_portrait,
                                        color: kPrimaryColor,
                                      ),
                                      Icon(CupertinoIcons.radiowaves_right,
                                          size: 10, color: kPrimaryColor),
                                      SizedBox(width: 10),
                                      Text('Non Tunai',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var idTiket = widget.dataTiket['idTiket'];
                                      HttpApi.recreatePayment(idTiket)
                                          .then((value) {
                                        dataResponse = value;
                                        print(dataResponse.textMessage);
                                        if (dataResponse.textMessage ==
                                            'Pembayaran ulang berhasil') {
                                          var linkPayment = dataResponse
                                              .bodyResponse!['dataPayment']
                                                  ['linkPayment']
                                              .toString();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SnapMidtrans(
                                                          idTiket: idTiket,
                                                          linkPayment:
                                                              linkPayment)));
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text('Bayar Sekarang',
                                          style: TextStyle(
                                              color: kWhiteColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(height: 1, color: kGreyColor),
                            const SizedBox(height: 15),
                          ],
                        )
                      : const SizedBox(width: 0),
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
                        SizedBox(height: getHeight(15)),
                        const Text('Nama Pemesan',
                            style: TextStyle(color: kGreyColor)),
                        SizedBox(height: getHeight(3)),
                        Text(dataPengguna['nama'],
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
                        const Text('08:00-17:00 WIB',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  (metodeBayar == 'Non Tunai' &&
                          statusBayar == 'Menunggu Pembayaran')
                      ? Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: getHeight(15)),
                                const Text('Jumlah Pengunjung',
                                    style: TextStyle(color: kGreyColor)),
                                SizedBox(height: getHeight(3)),
                                Text('$jumlahPengunjung Orang',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: getHeight(15)),
                                const Text('Jumlah Tiket',
                                    style: TextStyle(color: kGreyColor)),
                                SizedBox(height: getHeight(3)),
                                Text('$jumlahTiket Tiket',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ]),
                        )
                      : Column(
                          children: [
                            SizedBox(height: getHeight(15)),
                            Container(height: 1, color: kGreyColor),
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
                                    const Text('Metode Pembayaran',
                                        style: TextStyle(color: kGreyColor)),
                                    SizedBox(height: getHeight(3)),
                                    Text(metodeBayar,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('Total Bayar',
                                        style: TextStyle(color: kGreyColor)),
                                    SizedBox(height: getHeight(3)),
                                    Text(formatRupiah(totalBayar),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                  ((metodeBayar == 'Tunai' && statusBayar == 'Belum Lunas') ||
                          (metodeBayar == 'Non Tunai' &&
                              statusBayar == 'Lunas'))
                      ? Column(
                          children: [
                            SizedBox(height: getHeight(15)),
                            Container(height: 1, color: kGreyColor),
                            SizedBox(height: getHeight(15)),
                            const Text(
                              'Pindai Kode ini di Loket Pembayaran',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: getHeight(10)),
                            PrettyQr(
                              data: widget.dataTiket['kodeQr'],
                              size: getWidth(220),
                              errorCorrectLevel: QrErrorCorrectLevel.L,
                            ),
                            SizedBox(height: getHeight(10)),
                            Text(widget.dataTiket['kodeEt']),
                            SizedBox(height: getHeight(15)),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Catatan:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('\u2022'),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Text(
                                            'Batas scan tiket sebelum jam operasional tutup yaitu pukul 16:00.',
                                            textAlign: TextAlign.justify))
                                  ],
                                ),
                                SizedBox(height: 3),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('\u2022'),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Text(
                                            'Datang sesuai tanggal dan jam pada tiket.',
                                            textAlign: TextAlign.justify))
                                  ],
                                ),
                                SizedBox(height: 3),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('\u2022'),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: Text(
                                            'Simpan dan scan tiket ini di loket!',
                                            textAlign: TextAlign.justify))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(width: 0),
                  SizedBox(height: getHeight(20)),
                ],
              ),
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      )),
    );
  }
}
