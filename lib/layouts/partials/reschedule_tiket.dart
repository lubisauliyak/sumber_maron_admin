import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_tiket_khusus.dart';
import 'package:sumbermaron_admin/layouts/screens/main_screen.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/services/secure_http.dart';
import 'package:sumbermaron_admin/utils/choice_config.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class RescheduleTiket extends StatefulWidget {
  const RescheduleTiket({
    Key? key,
    required this.dataTiket,
  }) : super(key: key);

  final Map<String, dynamic> dataTiket;

  @override
  State<RescheduleTiket> createState() => _RescheduleTiketState();
}

class _RescheduleTiketState extends State<RescheduleTiket> {
  HttpApi dataResponse = HttpApi();

  List<dynamic> dataHariLibur = muatHariLibur();

  late var idTiket = widget.dataTiket['idTiket'] ?? '';
  late var tanggalBooking = widget.dataTiket['tanggalBooking'] ?? '';

  final TextEditingController _controllerTanggal = TextEditingController();

  String? tanggalPembelian;
  var tanggalInitial = '';
  var jumlahPengunjung = '0';
  var jumlahTiket = '0';
  var diskonTiket = '0';
  var totalBayar = '0';
  var hargaTiket = '0';
  String weekTiket = '';

  @override
  void dispose() {
    _controllerTanggal.dispose();
    super.dispose();
  }

  @override
  void initState() {
    var hasil = formatWeekTiket(tanggalBooking, dataHariLibur);
    DateTime tanggalHariIni = DateTime.now();
    DateTime parsedTanggalBooking = DateTime.parse(tanggalBooking);
    setState(() {
      if (parsedTanggalBooking.isBefore(tanggalHariIni)) {
        tanggalInitial = tanggalHariIni.toString();
      } else {
        tanggalInitial = parsedTanggalBooking.toString();
      }
      jumlahPengunjung = widget.dataTiket['jumlahPengunjung'].toString();
      jumlahTiket = widget.dataTiket['jumlahTiket'].toString();
      diskonTiket = widget.dataTiket['diskonTiket'].toString();
      weekTiket = hasil[0];
      hargaTiket = hasil[1];
      totalBayar = widget.dataTiket['totalBayar'].toString();
      _controllerTanggal.text = formatTanggalIndonesia(tanggalBooking);
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
              icon:
                  const Icon(CupertinoIcons.left_chevron, color: kWhiteColor)),
          title: const Text('Reschedule Tiket',
              style: TextStyle(color: kWhiteColor)),
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
                  readOnly: true,
                  controller: _controllerTanggal,
                  decoration: const InputDecoration(
                      labelText: 'Tanggal Pembelian',
                      hintText: 'Pilih tanggal pembelian',
                      suffixIcon: Icon(CupertinoIcons.calendar)),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(tanggalInitial),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      helpText: 'Pilih Tanggal',
                      cancelText: 'Batalkan',
                      confirmText: 'Pilih',
                    );
                    if (pickedDate != null) {
                      var tanggal = DateFormat('yyyy-MM-dd').format(pickedDate);
                      var hasil = formatWeekTiket(tanggal, dataHariLibur);
                      var week = hasil[0];
                      var harga = hasil[1];
                      setState(() {
                        tanggalPembelian = tanggal;
                        _controllerTanggal.text =
                            formatTanggalIndonesia(tanggalPembelian ?? '');
                        weekTiket = week;
                        hargaTiket = harga;
                        totalBayar =
                            (int.parse(jumlahTiket) * int.parse(hargaTiket))
                                .toString();
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: getHeight(20)),
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
                onPressed: (tanggalPembelian != null &&
                        widget.dataTiket['tanggalBooking'] != tanggalPembelian)
                    ? () {
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
                                  child: const Text('Reschedule tiket khusus?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                content: Column(
                                  children: [
                                    SizedBox(height: getHeight(10)),
                                    const Text(
                                        'Pastikan Anda sudah membaca syarat dan ketentuan untuk melanjutkan.'),
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
                                      HttpApi.rescheduleTiket(
                                        idTiket,
                                        tanggalPembelian.toString(),
                                        hargaTiket,
                                        weekTiket,
                                        totalBayar,
                                      ).then((value) {
                                        dataResponse = value;
                                        if (dataResponse.textMessage ==
                                            'Reschedule tiket khusus berhasil') {
                                          Map<String, dynamic> dataTiket =
                                              dataResponse
                                                  .bodyResponse!['dataTiket'];
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen()));
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailTiketKhusus(
                                                          dataTiket:
                                                              dataTiket)));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                getHeight(10)),
                                                    decoration: BoxDecoration(
                                                        color: kWhiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: const Text(
                                                        'Reschedule gagal?',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  content: Column(children: [
                                                    SizedBox(
                                                        height: getHeight(10)),
                                                    Text(dataResponse
                                                            .textMessage ??
                                                        'Pastikan data reschedule tiket lengkap.')
                                                  ]),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: const Text(
                                                        'Saya mengerti',
                                                        style: TextStyle(
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
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
                child: const Text('Reschedule Tiket',
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.bold)))));
  }
}
