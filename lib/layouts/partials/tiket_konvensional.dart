import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_tiket_masuk.dart';
import 'package:sumbermaron_admin/layouts/screens/main_screen.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/services/secure_http.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class TiketKonvensional extends StatefulWidget {
  const TiketKonvensional({super.key});

  @override
  State<TiketKonvensional> createState() => _TiketKonvensionalState();
}

class _TiketKonvensionalState extends State<TiketKonvensional> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataHariLibur = muatHariLibur();

  final TextEditingController _controllerPengunjung = TextEditingController();

  String tanggalPembelian = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var jumlahPengunjung = '0';
  var pesanInputTiket = '';
  var jumlahTiket = '0';
  var diskonTiket = '0';
  var totalBayar = '0';
  var hargaTiket = '0';
  String weekTiket = '';

  @override
  void dispose() {
    _controllerPengunjung.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var hasil = formatWeekTiket(tanggalPembelian, dataHariLibur);
    setState(() {
      weekTiket = hasil[0];
      hargaTiket = hasil[1];
      totalBayar = (int.parse(jumlahTiket) * int.parse(hargaTiket)).toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (_controllerPengunjung.text.isNotEmpty) {
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
                          child: const Text('Keluar halaman ini?',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        content: Column(children: [
                          SizedBox(height: getHeight(10)),
                          const Text(
                              'Data pengisian tiket konvensional saat ini tidak akan disimpan.')
                        ]),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(
                              'Lanjutkan pengisian data',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text(
                              'Keluar',
                              style: TextStyle(
                                  color: kRedColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()));
                            },
                          )
                        ],
                      );
                    });
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
          'Tiket Konvensional',
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tanggal Pembelian:'),
                  Text(formatTanggalIndonesia(tanggalPembelian),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: getHeight(30)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                  controller: _controllerPengunjung,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Jumlah Pengunjung',
                      hintText: 'Masukkan jumlah pengunjung',
                      suffixIcon: Icon(CupertinoIcons.person_3)),
                  onChanged: (value) {
                    int pengunjung = int.tryParse(value) ?? 0;
                    int diskon = 0;
                    if (pengunjung >= 30) {
                      diskon = (pengunjung / 10).floor();
                    }
                    int tiket = pengunjung - diskon;
                    setState(() {
                      jumlahPengunjung = pengunjung.toString() == ''
                          ? '0'
                          : pengunjung.toString();
                      jumlahTiket = tiket.toString();
                      diskonTiket = diskon.toString();
                      totalBayar = (tiket * int.parse(hargaTiket)).toString();
                    });
                  },
                  onTap: () {
                    setState(() {
                      pesanInputTiket =
                          'Usia 3 tahun ke atas wajib membeli tiket.';
                    });
                  },
                  onSubmitted: (String value) {
                    setState(() {
                      pesanInputTiket = '';
                    });
                  }),
            ),
            pesanInputTiket != ''
                ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: getHeight(2), bottom: getHeight(12)),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Text(pesanInputTiket,
                        style: const TextStyle(
                            color: kRedColor, fontSize: sizeDescription)))
                : SizedBox(height: getHeight(30)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
              padding: EdgeInsets.symmetric(
                  horizontal: getWidth(20), vertical: getHeight(20)),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  border: Border.all(color: kBlackColor),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Jumlah Pengunjung:'),
                    Text('$jumlahPengunjung Orang'),
                  ],
                ),
                SizedBox(height: getHeight(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Diskon Tiket:'),
                    Text(
                      diskonTiket == '0'
                          ? 'Tidak ada diskon'
                          : '-$diskonTiket Tiket',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kRedColor,
                          fontWeight: diskonTiket == '0'
                              ? FontWeight.normal
                              : FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(20)),
                Container(height: 1, color: kGreyColor),
                SizedBox(height: getHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Tiket:'),
                    Text('$jumlahTiket Tiket'),
                  ],
                ),
                SizedBox(height: getHeight(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Harga Tiket: ${weekTiket != '' ? '[$weekTiket]' : ''}'),
                    Text('x ${formatRupiah(hargaTiket)}'),
                  ],
                ),
                SizedBox(height: getHeight(20)),
                Container(height: 1, color: kGreyColor),
                SizedBox(height: getHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Bayar:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(formatRupiah(totalBayar),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ]),
            ),
            SizedBox(height: getHeight(30)),
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: getHeight(120),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: getHeight(30)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: getHeight(50),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: jumlahPengunjung != '0'
                    ? () {
                        terimaPembayaran(
                            context,
                            jumlahPengunjung,
                            jumlahTiket,
                            diskonTiket,
                            hargaTiket,
                            weekTiket,
                            totalBayar,
                            'Tunai');
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
                onPressed: jumlahPengunjung != '0'
                    ? () {
                        terimaPembayaran(
                            context,
                            jumlahPengunjung,
                            jumlahTiket,
                            diskonTiket,
                            hargaTiket,
                            weekTiket,
                            totalBayar,
                            'QRIS');
                      }
                    : null,
                style: OutlinedButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    side: BorderSide(
                        color: jumlahPengunjung != '0'
                            ? kPrimaryColor
                            : kGreyColor)),
                child: Text(
                  'Terima Pembayaran QRIS',
                  style: TextStyle(
                      color:
                          jumlahPengunjung != '0' ? kPrimaryColor : kGreyColor,
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
      BuildContext context,
      String jumlahPengunjung,
      String jumlahTiket,
      String diskonTiket,
      String hargaTiket,
      String weekTiket,
      String totalBayar,
      String jenisPembayaran) {
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
                  HttpApi.tiketKonvensional(
                          jumlahPengunjung,
                          jumlahTiket,
                          diskonTiket,
                          hargaTiket,
                          weekTiket,
                          totalBayar,
                          jenisPembayaran)
                      .then((value) {
                    dataResponse = value;
                    if (dataResponse.textMessage ==
                        'Beli tiket konvensional berhasil') {
                      Map<String, dynamic> dataTiket =
                          dataResponse.bodyResponse!['dataTiket'];
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const MainScreen(pilihScreen: 1)));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailTiketMasuk(dataTiket: dataTiket)));
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
