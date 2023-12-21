import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sumbermaron/layouts/partials/detail_tiket_aktif.dart';
import 'package:sumbermaron/layouts/partials/snap_midtrans.dart';

import 'package:sumbermaron/layouts/partials/tentang.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/utils/choice_config.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';

class PesanTiket extends StatefulWidget {
  const PesanTiket({
    Key? key,
    this.namaPromo,
    this.promoTiket,
    this.tiketMinimal,
    this.tanggalBooking,
    this.metodeBayar,
  }) : super(key: key);

  final String? namaPromo,
      promoTiket,
      tiketMinimal,
      tanggalBooking,
      metodeBayar;

  @override
  State<PesanTiket> createState() => _PesanTiketState();
}

class _PesanTiketState extends State<PesanTiket> {
  HttpApi dataResponse = HttpApi();

  late var namaPromo = widget.namaPromo ?? '';
  late var promoTiket = widget.promoTiket ?? '';
  late var tiketMinimal = widget.tiketMinimal ?? '';
  late var tanggalBooking = widget.tanggalBooking ?? '';
  late var metodeBayar = widget.metodeBayar ?? '';

  List<dynamic> dataHariLibur = muatHariLibur();

  final TextEditingController _controllerTanggal = TextEditingController();
  final TextEditingController _controllerPengunjung = TextEditingController();

  String? tanggalPembelian;
  String? jenisPembayaran;
  var jumlahPengunjung = '0';
  var pesanInputTiket = '';
  var jumlahTiket = '0';
  var diskonTiket = '0';
  var totalBayar = '0';
  var hargaTiket = '0';
  String weekTiket = '';

  @override
  void dispose() {
    _controllerTanggal.dispose();
    _controllerPengunjung.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      if (tiketMinimal != '') {
        _controllerPengunjung.text = tiketMinimal;
        jumlahPengunjung = tiketMinimal;
      }
      if (promoTiket != '') {
        diskonTiket = promoTiket;
        jumlahTiket =
            (int.parse(jumlahPengunjung) - int.parse(diskonTiket)).toString();
      }
      if (tanggalBooking != '') {
        var week = 'Hari Kerja';
        var harga = '5000';
        DateTime parsedTanggal = DateTime.parse(tanggalBooking);
        String hari = dayID[parsedTanggal.weekday - 1];
        if (dataHariLibur.contains(tanggalBooking)) {
          week = 'Hari Libur';
          harga = '10000';
        } else if (hari == 'Sabtu' || hari == 'Minggu') {
          week = 'Akhir Pekan';
          harga = '10000';
        }
        setState(() {
          tanggalPembelian = tanggalBooking;
          _controllerTanggal.text =
              formatTanggalIndonesia(tanggalPembelian ?? '');
          weekTiket = week;
          hargaTiket = harga;
          totalBayar =
              (int.parse(jumlahTiket) * int.parse(hargaTiket)).toString();
        });
      }
    });
    if (metodeBayar != '') {
      setState(() {
        jenisPembayaran = metodeBayar;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (_controllerTanggal.text.isNotEmpty ||
                  jenisPembayaran != null) {
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
                              'Data pengisian tiket Anda saat ini tidak akan disimpan.')
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainScreen()));
              }
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        title: const Text(
          'Form Pengisian Tiket',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Tentang()));
              },
              icon: const Icon(
                CupertinoIcons.info_circle_fill,
                color: kWhiteColor,
              )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: getHeight(30)),
            const Text('RENCANAKAN DAN',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: sizeTitle,
                    fontWeight: FontWeight.bold)),
            const Text('PESAN TIKETMU!',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: sizeTitle,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: getHeight(40)),
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
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    helpText: 'Pilih Tanggal',
                    cancelText: 'Batalkan',
                    confirmText: 'Pilih',
                  );
                  if (pickedDate != null) {
                    var tanggal = DateFormat('yyyy-MM-dd').format(pickedDate);
                    var week = 'Hari Kerja';
                    var harga = '5000';
                    DateTime parsedTanggal = DateTime.parse(tanggal);
                    String hari = dayID[parsedTanggal.weekday - 1];
                    if (dataHariLibur.contains(tanggal)) {
                      week = 'Hari Libur';
                      harga = '10000';
                    } else if (hari == 'Sabtu' || hari == 'Minggu') {
                      week = 'Akhir Pekan';
                      harga = '10000';
                    }
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
                        top: getHeight(3), bottom: getHeight(15)),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Text(pesanInputTiket,
                        style: const TextStyle(
                            color: kRedColor, fontSize: sizeDescription)))
                : SizedBox(
                    height: getHeight(30),
                  ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
              child: DropdownButtonFormField(
                value: jenisPembayaran,
                hint: const Text('Pilih jenis pembayaran'),
                onChanged: (String? newValue) {
                  setState(() {
                    jenisPembayaran = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem<String>(
                      value: 'Tunai', child: Text('Tunai')),
                  DropdownMenuItem<String>(
                      value: 'Non Tunai', child: Text('Non Tunai'))
                ],
                decoration:
                    const InputDecoration(labelText: 'Jenis Pembayaran'),
              ),
            ),
            namaPromo != ''
                ? Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 3),
                    padding: EdgeInsets.symmetric(horizontal: getWidth(30)),
                    child: GestureDetector(
                      onTap: () {
                        dialogHapusPromo();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Batalkan Promo $namaPromo ',
                              style: const TextStyle(
                                  color: kRedColor, fontSize: sizeDescription)),
                          const Icon(CupertinoIcons.trash,
                              size: 15, color: kRedColor)
                        ],
                      ),
                    ))
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
                    Text(
                        'Diskon Tiket: ${namaPromo != '' ? '[$namaPromo]' : ''}'),
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
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: (tanggalPembelian != null &&
                        jenisPembayaran != null &&
                        jumlahPengunjung != '0')
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
                                  child: const Text('Pesan tiket?',
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
                                      HttpApi.pesanTiket(
                                        tanggalPembelian ?? '',
                                        jumlahPengunjung,
                                        jenisPembayaran ?? '',
                                        jumlahTiket,
                                        diskonTiket,
                                        hargaTiket,
                                        weekTiket,
                                        totalBayar,
                                        namaPromo,
                                      ).then((value) {
                                        dataResponse = value;

                                        if (namaPromo != '') {
                                          HttpApi.dataBanner();
                                        }

                                        if (dataResponse.textMessage ==
                                            'Pesan tiket berhasil') {
                                          Map<String, dynamic> dataTiket =
                                              dataResponse
                                                  .bodyResponse!['dataTiket'];
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailTiketAktif(
                                                          dataTiket:
                                                              dataTiket)));
                                        } else if (dataResponse.textMessage ==
                                            'Menunggu pembayaran Non Tunai') {
                                          var idTiket = dataResponse
                                              .bodyResponse!['dataPayment']
                                                  ['idTiket']
                                              .toString();
                                          var linkPayment = dataResponse
                                              .bodyResponse!['dataPayment']
                                                  ['linkPayment']
                                              .toString();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SnapMidtrans(
                                                          idTiket: idTiket,
                                                          linkPayment:
                                                              linkPayment)));
                                        } else if (dataResponse.textMessage ==
                                            'Membuat ulang pembayaran Non Tunai') {
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
                                                        'Bayar Non Tunai?',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  content: Column(children: [
                                                    SizedBox(
                                                        height: getHeight(10)),
                                                    const Text(
                                                        'Pesan tiket berhasil, lakukan pembayaran Non Tunai')
                                                  ]),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: const Text(
                                                        'Bayar',
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
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const MainScreen(
                                                                        pilihScreen:
                                                                            1)));
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
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
                                                        'Pesan tiket gagal?',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  content: Column(children: [
                                                    SizedBox(
                                                        height: getHeight(10)),
                                                    const Text(
                                                        'Pastikan data pesan tiket lengkap dan sedang terhubung internet.')
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
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CupertinoAlertDialog(
                                                title: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: getHeight(10)),
                                                  decoration: BoxDecoration(
                                                      color: kWhiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: const Text(
                                                      'Koneksi internet?',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                content: Column(children: [
                                                  SizedBox(
                                                      height: getHeight(10)),
                                                  const Text(
                                                      'Pastikan Anda sedang terhubung internet.')
                                                ]),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: const Text(
                                                      'Saya mengerti',
                                                      style: TextStyle(
                                                          color: kPrimaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
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
                child: const Text('Pesan Sekarang',
                    style: TextStyle(
                        color: kWhiteColor, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: getHeight(30)),
          ],
        ),
      )),
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

  void dialogHapusPromo() {
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
              Text('Saya tidak ingin menggunakan promo $namaPromo.')
            ]),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  'Gunakan promo',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
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
                    diskonTiket = '0';
                    jumlahTiket =
                        (int.parse(jumlahPengunjung) - int.parse(diskonTiket))
                            .toString();
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
