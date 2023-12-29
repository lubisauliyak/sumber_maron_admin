import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper sp = SPHelper._();
  SharedPreferences? prefs;
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> save(String name, String value) async {
    await prefs!.setString(name, value);
  }

  String? get(String key) {
    return prefs!.getString(key);
  }

  Future<bool> delete(String key) async {
    return await prefs!.remove(key);
  }
}

void simpanAkun(Map<String, dynamic> dataPengguna) {
  SPHelper.sp.save('dataPengguna', jsonEncode(dataPengguna));
}

Map<String, dynamic> muatAkun() {
  var data = SPHelper.sp.get('dataPengguna') ?? '';
  Map<String, dynamic> dataPengguna = jsonDecode(data);
  return dataPengguna;
}

bool cekAkun() {
  var dataPengguna = SPHelper.sp.get('dataPengguna');
  if (dataPengguna != null) {
    return true;
  }
  return false;
}

void simpanHariLibur(List<dynamic> dataHariLibur) {
  SPHelper.sp.save('dataHariLibur', jsonEncode(dataHariLibur));
}

List<dynamic> muatHariLibur() {
  var data = SPHelper.sp.get('dataHariLibur') ?? '';
  List<dynamic> dataHariLibur = jsonDecode(data);
  return dataHariLibur;
}

void simpanBanner(List<dynamic> dataBanner) {
  SPHelper.sp.save('dataBanner', jsonEncode(dataBanner));
}

List<dynamic> muatBanner() {
  var data = SPHelper.sp.get('dataBanner') ?? '';
  List<dynamic> dataBanner = jsonDecode(data);
  return dataBanner;
}

void simpanLokasiParkir(Map<String, dynamic> dataLokasiParkir) {
  SPHelper.sp.save('dataLokasiParkir', jsonEncode(dataLokasiParkir));
}

Map<String, dynamic> muatLokasiParkir() {
  var data = SPHelper.sp.get('dataLokasiParkir') ?? '';
  Map<String, dynamic> dataLokasiParkir = jsonDecode(data);
  return dataLokasiParkir;
}

void keluarAkun() {
  SPHelper.sp.delete('dataPengguna');
  SPHelper.sp.delete('dataBanner');
  SPHelper.sp.delete('dataLokasiParkir');
  SPHelper.sp.delete('dataTiketAktif');
  SPHelper.sp.delete('dataRiwayatTiket');
  return;
}

void simpanTiketAktif(List<dynamic> dataTiketAktif) {
  SPHelper.sp.save('dataTiketAktif', jsonEncode(dataTiketAktif));
}

List<dynamic> muatTiketAktif() {
  var data = SPHelper.sp.get('dataTiketAktif') ?? '';
  List<dynamic> dataTiketAktif = [];
  if (data != '') {
    dataTiketAktif = jsonDecode(data);
  }
  return dataTiketAktif;
}

void simpanRiwayatTiket(List<dynamic> dataRiwayatTiket) {
  SPHelper.sp.save('dataRiwayatTiket', jsonEncode(dataRiwayatTiket));
}

List<dynamic> muatRiwayatTiket() {
  var data = SPHelper.sp.get('dataRiwayatTiket') ?? '';
  List<dynamic> dataRiwayatTiket = [];
  if (data != '') {
    dataRiwayatTiket = jsonDecode(data);
  }
  return dataRiwayatTiket;
}
