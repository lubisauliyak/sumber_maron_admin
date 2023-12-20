import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class Tentang extends StatelessWidget {
  const Tentang({super.key});

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
          'Tentang',
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
            Image.asset('assets/images/bg_sumbermaron.jpg',
                height: getHeight(250),
                width: double.infinity,
                fit: BoxFit.cover,
                color: kPrimaryColor.withOpacity(.25),
                colorBlendMode: BlendMode.colorBurn),
            SizedBox(height: getHeight(30)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                alignment: Alignment.centerLeft,
                child: const Text('Sumber Maron',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: sizeTitle))),
            SizedBox(height: getHeight(20)),
            Container(
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                alignment: Alignment.centerLeft,
                child: const Text(
                    'Wisata Sumber Maron menawarkan wisata alam ala pedesaan di Malang yang masih asri dimana terdapat arung jeram, susur sungai dengan ban dan berenang melewati area alam yang dilindungi. Selain berenang, pengunjung juga dapat mencoba wahana Flying Fox dan Terapi Ikan yang sangat bermanfaat bagi kesehatan, serta dilengkapi kafe dengan berbagai macam makanan.',
                    textAlign: TextAlign.justify)),
            SizedBox(height: getHeight(20)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Syarat dan Ketentuan',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(
                              'Terdapat dua jenis harga tiket. Pada hari kerja sebesar Rp 5.000/tiket. Sedangkan pada hari libur dan akhir pekan sebesar Rp 10.000/tiket.',
                              textAlign: TextAlign.justify))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(
                              'Kondisi badan sehat dan fit saat berkunjung.',
                              textAlign: TextAlign.justify))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text('Menjaga Kebersihan tempat wisata.',
                              textAlign: TextAlign.justify))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022'),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(
                              'Mengikuti himbauan dan petunjuk petugas wisata.',
                              textAlign: TextAlign.justify))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      )),
    );
  }
}
