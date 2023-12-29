import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sumbermaron/layouts/partials/pesan_tiket.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/choice_config.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class DetailRiwayatTiket extends StatelessWidget {
  const DetailRiwayatTiket({
    Key? key,
    required this.dataTiket,
  }) : super(key: key);

  final Map<String, dynamic> dataTiket;

  @override
  Widget build(BuildContext context) {
    var dataPengguna = muatAkun();

    var jumlahPengunjung = dataTiket['jumlahPengunjung'];
    var jumlahTiket = dataTiket['jumlahTiket'];
    var totalBayar = dataTiket['totalBayar'];
    var tanggalBooking = dataTiket['tanggalBooking'];
    var metodeBayar = dataTiket['metodeBayar'];
    var statusBayar = dataTiket['statusBayar'];

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
          'Detail Riwayat Tiket',
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
                              SizedBox(height: getHeight(15)),
                              const Text('Nama Pemesan',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              Text(dataPengguna['nama'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: getHeight(15)),
                              const Text('Tanggal',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              Text(formatTanggalIndonesia(tanggalBooking),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: getHeight(15)),
                              const Text('Jam Operasional',
                                  style: TextStyle(color: kGreyColor)),
                              SizedBox(height: getHeight(3)),
                              const Text('08:00-17:00 WIB',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
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
                        SizedBox(height: getHeight(20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (cekPesanUlang(tanggalBooking) && statusBayar != 'Lunas')
                ? Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => PesanTiket(
                                promoTiket: '0',
                                tiketMinimal: jumlahPengunjung,
                                tanggalBooking: tanggalBooking,
                                metodeBayar: metodeBayar)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor),
                      child: const Text(
                        'Pesan Ulang',
                        style: TextStyle(
                            color: kWhiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : const SizedBox(width: 0),
            SizedBox(height: getHeight(50))
          ],
        ),
      )),
    );
  }

  bool cekPesanUlang(String tanggalBooking) {
    DateTime bookingDate = DateTime.parse(tanggalBooking);
    DateTime currentDate =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    if (currentDate.isAfter(bookingDate)) {
      return false;
    } else {
      return true;
    }
  }
}
