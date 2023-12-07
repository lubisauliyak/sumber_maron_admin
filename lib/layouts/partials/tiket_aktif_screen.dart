import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/utils/choice_config.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';

class TiketAktifScreen extends StatelessWidget {
  const TiketAktifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dataTiketAktif = [
      {
        'idTiket': '1',
        'pengunjung': '5',
        'jumlahTiket': '5',
        'totalBayar': '50000',
        'tanggalBooking': '2023-12-05',
        'metodeBayar': 'Tunai',
        'statusBayar': 'Belum Lunas',
      },
      {
        'idTiket': '2',
        'pengunjung': '3',
        'jumlahTiket': '3',
        'totalBayar': '30000',
        'tanggalBooking': '2023-12-05',
        'metodeBayar': 'Tunai',
        'statusBayar': 'Lunas',
      },
      {
        'idTiket': '3',
        'pengunjung': '7',
        'jumlahTiket': '7',
        'totalBayar': '70000',
        'tanggalBooking': '2023-12-05',
        'metodeBayar': 'Non-Tunai',
        'statusBayar': 'Lunas',
      },
      {
        'idTiket': '4',
        'pengunjung': '5',
        'jumlahTiket': '5',
        'totalBayar': '50000',
        'tanggalBooking': '2023-12-05',
        'metodeBayar': 'Non-Tunai',
        'statusBayar': 'Belum Lunas',
      },
      {
        'idTiket': '5',
        'pengunjung': '5',
        'jumlahTiket': '5',
        'totalBayar': '50000',
        'tanggalBooking': '2023-12-05',
        'metodeBayar': 'Non-Tunai',
        'statusBayar': 'Menunggu Pembayaran',
      },
    ];

    return Column(
      children: [
        ...dataTiketAktif.map((tiketAktif) {
          return TiketAktifItem(
              id: tiketAktif['idTiket'] ?? '',
              pengunjung: tiketAktif['pengunjung'] ?? '',
              tiket: tiketAktif['jumlahTiket'] ?? '',
              bayar: tiketAktif['totalBayar'] ?? '',
              tanggal: tiketAktif['tanggalBooking'] ?? '',
              metodeBayar: tiketAktif['metodeBayar'] ?? '',
              statusBayar: tiketAktif['statusBayar'] ?? '');
        }).toList(),
      ],
    );
  }
}

class TiketAktifItem extends StatelessWidget {
  const TiketAktifItem(
      {super.key,
      required this.id,
      required this.pengunjung,
      required this.tiket,
      required this.bayar,
      required this.tanggal,
      required this.metodeBayar,
      required this.statusBayar});

  final String id;
  final String pengunjung;
  final String tiket;
  final String bayar;
  final String tanggal;
  final String metodeBayar;
  final String statusBayar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: getHeight(20)),
      child: Container(
        padding: EdgeInsets.all(getWidth(15)),
        margin: EdgeInsets.symmetric(horizontal: getWidth(10)),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: (kGreyColor.withOpacity(.5))),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: (statusBorderColor[statusBayar]).withOpacity(.2),
              spreadRadius: 1,
              blurRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/smlogo_horizontal.png',
                      height: getHeight(20),
                    ),
                    Text(
                      formatTanggalIndonesia(tanggal),
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: getHeight(5), horizontal: getWidth(15)),
                  decoration: BoxDecoration(
                      color: statusBorderColor[statusBayar],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    statusBayar,
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: getHeight(15)),
            Container(
              height: 1,
              width: double.infinity,
              color: kGreyColor,
            ),
            SizedBox(height: getHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jumlah Tiket:'),
                    Text(
                      '$tiket Tiket',
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Total Bayar:'),
                    Text(
                      formatRupiah(bayar),
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: getHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Rombongan: '),
                    Text(
                      '$pengunjung Orang',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Lihat tiket ',
                          style: TextStyle(color: kSecondaryColor)),
                      Icon(
                        CupertinoIcons.chevron_down_circle,
                        color: kSecondaryColor,
                        size: getHeight(22),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
