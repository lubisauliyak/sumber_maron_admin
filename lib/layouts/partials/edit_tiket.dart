import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_tiket_scan.dart';
import 'package:sumbermaron_admin/layouts/screens/main_screen.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/secure_http.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class EditTiket extends StatefulWidget {
  const EditTiket({
    Key? key,
    required this.dataTiket,
  }) : super(key: key);

  final Map<String, dynamic> dataTiket;

  @override
  State<EditTiket> createState() => _EditTiketState();
}

class _EditTiketState extends State<EditTiket> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataHariLibur = ['2024-01-10', '2024-02-01'];

  late var idTiket = widget.dataTiket['idTiket'] ?? '';
  late var kodeTiket = widget.dataTiket['kodeTiket'] ?? '';
  late var tanggalBooking = widget.dataTiket['tanggalBooking'] ?? '';
  late var namaPromo = widget.dataTiket['namaPromo'] ?? '';
  late var promoTiket = widget.dataTiket['promoTiket'] ?? '';
  late var tiketMinimal = widget.dataTiket['tiketMinimal'] ?? '';

  final TextEditingController _controllerPengunjung = TextEditingController();
  final TextEditingController _controllerDiskon = TextEditingController();

  var jumlahPengunjung = '0';
  var pesanInputTiket = '';
  var jumlahTiket = '0';
  var diskonTiket = '0';
  var totalBayar = '0';
  var hargaTiket = '0';
  String weekTiket = '';
  var isDiskonEnable = true;

  @override
  void dispose() {
    _controllerPengunjung.dispose();
    _controllerDiskon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var hasil = formatWeekTiket(tanggalBooking, dataHariLibur);
    setState(() {
      jumlahPengunjung = widget.dataTiket['jumlahPengunjung'].toString();
      jumlahTiket = widget.dataTiket['jumlahTiket'].toString();
      diskonTiket = widget.dataTiket['diskonTiket'].toString();
      weekTiket = hasil[0];
      hargaTiket = hasil[1];
      totalBayar = widget.dataTiket['totalBayar'].toString();
      _controllerPengunjung.text = jumlahPengunjung;
      _controllerDiskon.text = diskonTiket;
    });
    super.initState();
  }

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
          'Edit Tiket',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                  controller: _controllerPengunjung,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Jumlah Pengunjung',
                      hintText: 'Masukkan jumlah pengunjung',
                      suffixIcon: Icon(CupertinoIcons.person_3)),
                  onChanged: (value) {
                    if (namaPromo != '' && int.parse(value) >= 30) {
                      setState(() {
                        namaPromo = '';
                        promoTiket = '';
                        tiketMinimal = '';
                      });
                      dialogMaxPromo();
                    }
                    if (namaPromo != '' &&
                        int.parse(tiketMinimal) > int.parse(value)) {
                      setState(() {
                        diskonTiket = '0';
                        jumlahTiket = (int.parse(jumlahPengunjung) -
                                int.parse(diskonTiket))
                            .toString();
                      });
                      dialogtiketMinimal();
                    }
                    int pengunjung = int.tryParse(value) ?? 0;
                    int diskon = 0;
                    if (namaPromo != '') {
                      diskon = int.parse(promoTiket);
                    }
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
            kodeTiket == 'TL'
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _controllerDiskon,
                          readOnly: isDiskonEnable,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Diskon Tiket',
                            hintText: 'Masukkan diskon tiket',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isDiskonEnable = !isDiskonEnable;
                                  });
                                },
                                icon: Icon(isDiskonEnable
                                    ? CupertinoIcons.ticket
                                    : CupertinoIcons.ticket_fill)),
                          ),
                          onChanged: (value) {
                            int diskon = int.parse(value);
                            int tiket = int.parse(jumlahPengunjung) - diskon;
                            setState(() {
                              if (tiket < 1) {
                                diskon = 0;
                                tiket = int.parse(jumlahPengunjung);
                              }
                              jumlahTiket = tiket.toString();
                              diskonTiket = diskon.toString();
                              _controllerDiskon.text = diskonTiket;
                              totalBayar =
                                  (tiket * int.parse(hargaTiket)).toString();
                            });
                          },
                          onSubmitted: (String value) {
                            isDiskonEnable = true;
                          },
                        ),
                      ),
                      SizedBox(height: getHeight(30)),
                    ],
                  )
                : SizedBox(height: getHeight(0)),
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
          ],
        ),
      )),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        margin: EdgeInsets.only(bottom: getHeight(30)),
        child: ElevatedButton(
          onPressed: (jumlahPengunjung != '0' &&
                  jumlahPengunjung != widget.dataTiket['jumlahPengunjung'])
              ? () {
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
                            child: const Text('Edit tiket?',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          content: Column(
                            children: [
                              SizedBox(height: getHeight(10)),
                              const Text(
                                  'Pastikan data yang dimasukkan sudah benar.'),
                            ],
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(
                                'Lanjutkan',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                HttpApi.editTiket(
                                  idTiket,
                                  jumlahPengunjung,
                                  jumlahTiket,
                                  diskonTiket,
                                  totalBayar,
                                ).then((value) {
                                  dataResponse = value;

                                  if (dataResponse.textMessage ==
                                      'Edit tiket berhasil') {
                                    Map<String, dynamic> dataTiket =
                                        dataResponse.bodyResponse!['dataTiket'];
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen()));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailTiketScan(
                                                    dataTiket: dataTiket)));
                                  }
                                }).catchError((error) {
                                  cekInternet(context);
                                });
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                    color: kRedColor,
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
              : null,
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          child: const Text('Edit Tiket',
              style:
                  TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void dialogtiketMinimal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: getHeight(10)),
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(20)),
              child: const Text('Hapus promo?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            content: Column(children: [
              SizedBox(height: getHeight(10)),
              Text(
                  'Syarat minimal $tiketMinimal pengunjung untuk melanjutkan promo $namaPromo.')
            ]),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  'Lanjutkan promo',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    _controllerPengunjung.text = tiketMinimal;
                    jumlahPengunjung = tiketMinimal;
                    diskonTiket = promoTiket;
                    jumlahTiket =
                        (int.parse(jumlahPengunjung) - int.parse(diskonTiket))
                            .toString();
                  });
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: const Text(
                  'Hapus',
                  style:
                      TextStyle(color: kRedColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    namaPromo = '';
                    promoTiket = '';
                    tiketMinimal = '';
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void dialogMaxPromo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: getHeight(10)),
              decoration: BoxDecoration(
                  color: kWhiteColor, borderRadius: BorderRadius.circular(20)),
              child: const Text('Sesuaikan promo?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            content: Column(children: [
              SizedBox(height: getHeight(10)),
              Text(
                  'Promo $namaPromo tidak dapat digunakan dengan promo lainnya.')
            ]),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  'Ya, saya mengerti',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
