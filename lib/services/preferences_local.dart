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

void simpanAkun(Map<String, dynamic> dataAdmin) {
  SPHelper.sp.save('dataAdmin', jsonEncode(dataAdmin));
}

Map<String, dynamic> muatAkun() {
  var data = SPHelper.sp.get('dataAdmin') ?? '';
  Map<String, dynamic> dataAdmin = jsonDecode(data);
  return dataAdmin;
}

bool cekAkun() {
  var dataAdmin = SPHelper.sp.get('dataAdmin');
  if (dataAdmin != null) {
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

void simpanSummary(List<dynamic> dataSummary) {
  SPHelper.sp.save('dataSummary', jsonEncode(dataSummary));
}

List<dynamic> muatSummary() {
  var data = SPHelper.sp.get('dataSummary') ?? '';
  List<dynamic> dataSummary = jsonDecode(data);
  return dataSummary;
}

void simpanTiketKhusus(List<dynamic> dataTiketKhusus) {
  SPHelper.sp.save('dataTiketKhusus', jsonEncode(dataTiketKhusus));
}

List<dynamic> muatTiketKhusus() {
  var data = SPHelper.sp.get('dataTiketKhusus') ?? '';
  List<dynamic> dataTiketKhusus = [];
  if (data != '') {
    dataTiketKhusus = jsonDecode(data);
  }
  return dataTiketKhusus;
}

void simpanTiketMasuk(List<dynamic> dataTiket) {
  SPHelper.sp.save('dataTiket', jsonEncode(dataTiket));
}

List<dynamic> muatTiketMasuk() {
  var data = SPHelper.sp.get('dataTiket') ?? '';
  List<dynamic> dataTiket = [];
  if (data != '') {
    dataTiket = jsonDecode(data);
  }
  return dataTiket;
}

void keluarAkun() {
  SPHelper.sp.delete('dataAdmin');
  SPHelper.sp.delete('dataHariLibur');
  SPHelper.sp.delete('dataSummary');
  SPHelper.sp.delete('dataTiketKhusus');
  SPHelper.sp.delete('dataTiket');
  return;
}
