import 'package:flutter/material.dart';
import 'package:official_sumbermaron/utils/choice_config.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';

class RiwayatTiketScreen extends StatelessWidget {
  const RiwayatTiketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dataRiwayatTiket = [
      {
        'pengunjung': '5',
        'jumlahTiket': '5',
        'totalBayar': '50000',
        'tanggalBooking': '2023-12-01',
        'metodeBayar': 'Tunai',
      },
      {
        'pengunjung': '3',
        'jumlahTiket': '3',
        'totalBayar': '30000',
        'tanggalBooking': '2023-12-02',
        'metodeBayar': 'Tunai',
      },
      {
        'pengunjung': '7',
        'jumlahTiket': '7',
        'totalBayar': '70000',
        'tanggalBooking': '2023-12-03',
        'metodeBayar': 'Non-Tunai',
      },
      {
        'pengunjung': '5',
        'jumlahTiket': '5',
        'totalBayar': '50000',
        'tanggalBooking': '2023-12-04',
        'metodeBayar': 'Non-Tunai',
      },
      {
        'pengunjung': '5',
        'jumlahTiket': '5',
        'totalBayar': '50000',
        'tanggalBooking': '2023-12-05',
        'metodeBayar': 'Non-Tunai',
      },
    ];
    return Column(
      children: [
        ...dataRiwayatTiket.map((tiketAktif) {
          return RiwayatTiketItem(
              pengunjung: tiketAktif['pengunjung'] ?? '',
              tiket: tiketAktif['jumlahTiket'] ?? '',
              bayar: tiketAktif['totalBayar'] ?? '',
              tanggal: tiketAktif['tanggalBooking'] ?? '',
              metodeBayar: tiketAktif['metodeBayar'] ?? '');
        }).toList(),
      ],
    );
  }
}

class RiwayatTiketItem extends StatelessWidget {
  const RiwayatTiketItem(
      {super.key,
      required this.pengunjung,
      required this.tiket,
      required this.bayar,
      required this.tanggal,
      required this.metodeBayar});

  final String pengunjung;
  final String tiket;
  final String bayar;
  final String tanggal;
  final String metodeBayar;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: getHeight(50),
        width: double.infinity,
        color: kGreyColor.withOpacity(.15),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Text(formatTanggalIndonesia(tanggal)),
      ),
      Container(
        color: kGreyColor.withOpacity(.15),
        child: Container(
          padding: EdgeInsets.all(getWidth(15)),
          margin: EdgeInsets.only(
              left: getWidth(10), right: getWidth(10), bottom: getWidth(20)),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: (kGreyColor.withOpacity(.5))),
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
                      Row(
                        children: [
                          Text('Rombongan: '),
                          Text(
                            '$pengunjung Orang',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getHeight(5), horizontal: getWidth(15)),
                    decoration: BoxDecoration(
                        color: kGreyColor.withOpacity(.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kGreyColor)),
                    child: Text(
                      metodeBayar,
                      style: TextStyle(color: kBlackColor),
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
            ],
          ),
        ),
      ),
      SizedBox(height: getHeight(20))
    ]);
  }
}
