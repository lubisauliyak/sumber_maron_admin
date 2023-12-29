import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class PusatBantuan extends StatefulWidget {
  const PusatBantuan({super.key});

  @override
  State<PusatBantuan> createState() => _PusatBantuanState();
}

class _PusatBantuanState extends State<PusatBantuan> {
  final Uri _whatsappUrl = Uri.parse(
      "https://api.whatsapp.com/send?phone=6288803337892&text=Perkenalkan%2C%20saya%20(nama)%0ABertanya%20untuk%20(pertanyaan)");

  Future<void> _openWhatsApp() async {
    if (!await launchUrl(_whatsappUrl)) {
      throw Exception('Tidak dapat membuka WhatsApp');
    }
  }

  var isQuest1 = false;
  var isQuest2 = false;
  var isQuest3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const MainScreen(pilihScreen: 2)));
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
          'Pusat Bantuan',
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
              height: 200,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 160,
                    color: kPrimaryColor,
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Halo, ada yang bisa kami bantu?',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold)),
                        Text('Silahkan pilih fitur chat admin untuk',
                            style: TextStyle(color: kWhiteColor)),
                        Text('menyampaikan pertanyaan Anda.',
                            style: TextStyle(color: kWhiteColor)),
                        SizedBox(height: 50)
                      ],
                    ),
                  ),
                  Positioned(
                      top: 120,
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: kGreyColor.withOpacity(.2)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                color: kSecondaryColor.withOpacity(.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.person_circle,
                              color: kPrimaryColor,
                              size: 50,
                            ),
                            SizedBox(width: getWidth(10)),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Admin siap membantu!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Yuk ngobrol langsung untuk',
                                    style:
                                        TextStyle(fontSize: sizeDescription)),
                                Text('mendapatkan bantuan.',
                                    style: TextStyle(fontSize: sizeDescription))
                              ],
                            ),
                            SizedBox(width: getWidth(20)),
                            GestureDetector(
                              onTap: () {
                                _openWhatsApp();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    border: Border.all(color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  'CHAT',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(height: getHeight(20)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text('Pertanyaan Populer',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: getHeight(20)),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(color: kGreyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isQuest1 = !isQuest1;
                        isQuest2 = false;
                        isQuest3 = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: getWidth(260),
                                child: const Text(
                                    'Mengapa harga wekeend dan weekday berbeda?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Icon(isQuest1
                                  ? CupertinoIcons.chevron_down
                                  : CupertinoIcons.right_chevron)
                            ],
                          ),
                          isQuest1
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    'Berdasarkan penetapan peraturan Badan Usaha Milik Desa (BUMDES) Karangsuko adanya pembedaan harga untuk hari kerja sebesar Rp 5.000/tiket. Sedangkan pada hari libur dan akhir pekan sebesar Rp 10.000/tiket.',
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              : const SizedBox(width: 0),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: kGreyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isQuest1 = false;
                        isQuest2 = !isQuest2;
                        isQuest3 = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: getWidth(260),
                                child: const Text(
                                    'Bagaimana cara melakukan pembayaran non tunai?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Icon(isQuest2
                                  ? CupertinoIcons.chevron_down
                                  : CupertinoIcons.right_chevron),
                            ],
                          ),
                          isQuest2
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Buka aplikasi Sumber Maron',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Pilih fitur form pengisian tiket.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Lakukan seluruh pengisian data pembelian tiket.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Pilih metode pembayaran non-tunai.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Halaman akan berpindah pada pembayaran digital.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Pilih payment channel untuk pembayaran.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Lakukan pembayaran sesuai arahan payment channel yang dipilih.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Jika pembayaran berhasil akan ditampilkan pesan pembayaran berhasil.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('\u2022'),
                                        SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                                'Jika pembayaran gagal akan ditampilkan pesan pembayaran gagal.',
                                                textAlign: TextAlign.justify))
                                      ],
                                    ),
                                  ]),
                                )
                              : const SizedBox(width: 0),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: kGreyColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isQuest1 = false;
                        isQuest2 = false;
                        isQuest3 = !isQuest3;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: getWidth(260),
                                child: const Text(
                                    'Adakah perbedaan tiket tunai dengan tiket non tunai?',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Icon(isQuest3
                                  ? CupertinoIcons.chevron_down
                                  : CupertinoIcons.right_chevron)
                            ],
                          ),
                          isQuest3
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                      'Kedua tiket tersebut memiliki perbedaan pada proses pembayaran. Apabila tiket tunai Anda dapat melakukan pesan saja dan pembayaran tetap secara langsung pada loket Sumber Maron. Namun, apabila non tunai Anda dapat melakukan pesan dan pembayaran secara lunas melalui pembayaran digital yang disediakan.\nSelain itu, terdapat perbedaan label status pada halaman tiket aktif, dimana tiket tunai memiliki label “Belum Lunas”, dan tiket non tunai yang sudah melakukan pembayaran memiliki label “Lunas”.',
                                      textAlign: TextAlign.justify))
                              : const SizedBox(width: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getHeight(50)),
          ],
        ),
      )),
    );
  }
}
