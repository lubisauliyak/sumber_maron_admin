import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/home_screen.dart';
import 'package:official_sumbermaron/layouts/screen/riwayat_screen.dart';
import 'package:official_sumbermaron/utils/choice_config.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TiketScreen extends StatelessWidget {
  const TiketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> dataTiket = {
      'idTiket': '1',
      'pengunjung': '5',
      'jumlahTiket': '5',
      'totalBayar': '50000',
      'tanggalBooking': '2023-12-05',
      'metodeBayar': 'Non-Tunai',
      'statusBayar': 'Lunas',
      'kodeEt': 'ET-',
      'kodeQr': 'abcde',
    };

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getHeight(10),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_tiket.jpg'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(kWhiteColor, BlendMode.softLight))),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: getHeight(20)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
                padding: EdgeInsets.all(getWidth(20)),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/smlogo.png',
                          height: getWidth(35),
                        ),
                        Column(
                          children: [
                            Text(
                              'Tiket Booking',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Wisata Alam Sumber Maron',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: getWidth(30)),
                      ],
                    ),
                    SizedBox(height: getHeight(20)),
                    Container(
                      color: kGreyColor,
                      height: getHeight(1),
                    ),
                    SizedBox(height: getHeight(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama Pemesan :',
                                  style: TextStyle(color: kGreyColor)),
                              Text('Megawati Aswiya',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getHeight(5), horizontal: getWidth(15)),
                          decoration: BoxDecoration(
                              color:
                                  statusBorderColor[dataTiket['statusBayar']],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            dataTiket['statusBayar'],
                            style: TextStyle(color: kWhiteColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getHeight(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jumlah Rombongan :',
                                  style: TextStyle(color: kGreyColor)),
                              Text('${dataTiket['pengunjung']} Orang',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Jumlah Tiket :',
                                  style: TextStyle(color: kGreyColor)),
                              Text('${dataTiket['jumlahTiket']} Tiket',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ],
                    ),
                    SizedBox(height: getHeight(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Metode Pembayaran :',
                                  style: TextStyle(color: kGreyColor)),
                              Text(dataTiket['metodeBayar'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Total Bayar :',
                                  style: TextStyle(color: kGreyColor)),
                              Text(formatRupiah(dataTiket['totalBayar']),
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ],
                    ),
                    SizedBox(height: getHeight(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tanggal Booking :',
                                  style: TextStyle(color: kGreyColor)),
                              Text(
                                  formatTanggalIndonesia(
                                      dataTiket['tanggalBooking']),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Jam Operasional :',
                                  style: TextStyle(color: kGreyColor)),
                              Text('08:00 - 17:00 WIB',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ]),
                      ],
                    ),
                    SizedBox(height: getHeight(15)),
                    Container(
                      color: kGreyColor,
                      height: getHeight(1),
                    ),
                    SizedBox(height: getHeight(15)),
                    (dataTiket['metodeBayar'] != 'Tunai' &&
                            dataTiket['statusBayar'] != 'Lunas')
                        ? Column(
                            children: [
                              Text(
                                'Lakukan Pembayaran terlebih dahulu',
                                style: TextStyle(
                                    color: kRedColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                'Pindai Kode QR di Loket Pembayaran :',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: getHeight(10)),
                              PrettyQr(
                                data: dataTiket['kodeQr'],
                                size: getWidth(170),
                                roundEdges: true,
                                typeNumber: null,
                                errorCorrectLevel: QrErrorCorrectLevel.L,
                              ),
                              SizedBox(height: getHeight(10)),
                              Text(dataTiket['kodeEt']),
                              SizedBox(height: getHeight(15)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Catatan :',
                                      style: TextStyle(
                                          color: kGreyColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(' \u2022'),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Text(
                                        'Batas scan tiket paling lambat 1 jam sebelum jam operasional berakhir yaitu pukul 16:00 WIB',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(color: kGreyColor),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(' \u2022'),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Text(
                                        'Datanglah sesuai tanggal dan jam operasional yang tercantum dalam tiket.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(color: kGreyColor),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(' \u2022'),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Text(
                                        'Simpanlah dan scan tiket di loket masuk.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: kGreyColor,
                                        ),
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(' \u2022'),
                                      SizedBox(width: 5),
                                      Expanded(
                                          child: Text(
                                        'Jagalah kebersihan di lingkungan tempat wisata dengan baik.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(color: kGreyColor),
                                      ))
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                  ],
                ),
              ),
              SizedBox(height: getHeight(15)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
                padding: EdgeInsets.all(getWidth(20)),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    (dataTiket['metodeBayar'] != 'Tunai' &&
                            dataTiket['statusBayar'] != 'Lunas')
                        ? Container(
                            width: double.infinity,
                            height: getHeight(50),
                            margin: EdgeInsets.only(bottom: getHeight(15)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kGreenColor),
                              child: Text(
                                'Bayar',
                                style: TextStyle(color: kWhiteColor),
                              ),
                            ),
                          )
                        : SizedBox(width: 0),
                    (dataTiket['metodeBayar'] == 'Tunai' ||
                            (dataTiket['metodeBayar'] == 'Non-Tunai' &&
                                dataTiket['statusBayar'] == 'Lunas'))
                        ? Container(
                            width: double.infinity,
                            height: getHeight(50),
                            margin: EdgeInsets.only(bottom: getHeight(15)),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kOrangeColor),
                              child: Text(
                                'Reschedule Tiket',
                                style: TextStyle(color: kWhiteColor),
                              ),
                            ),
                          )
                        : SizedBox(width: 0),
                    Container(
                      width: double.infinity,
                      height: getHeight(50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const RiwayatScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor),
                        child: Text(
                          'Kembali',
                          style: TextStyle(color: kWhiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
