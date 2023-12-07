import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:official_sumbermaron/services/prefs_local.dart';

String getApiKeyGlobal() {
  var apiKey =
      '54rNNpSTD4A912E23F839538705E055C2550B916635DED61A86DEA4C87FCC4E4D2457168';
  List<int> bytesApiKey = utf8.encode(apiKey);
  return 'Key ${base64.encode(bytesApiKey)}';
}

String getApiKey() {
  var dataUser = getDataUser();
  String apiKey = dataUser['apiKey'];
  List<int> bytesApiKey = utf8.encode(apiKey);
  return 'Key ${base64.encode(bytesApiKey)}';
}

String digiest(String data) {
  var bytes = utf8.encode(data);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

Map<String, dynamic> getDataUser() {
  var dataUser = SPHelper.sp.get('dataUser') ?? "";
  return json.decode(dataUser);
}

bool loadRemember() {
  var dataUser = SPHelper.sp.get('dataUser');
  if (dataUser != null) {
    return true;
  }
  return false;
}

void logoutUser() {
  SPHelper.sp.delete('dataUser');
  return;
}
