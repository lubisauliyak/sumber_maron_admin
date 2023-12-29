import 'dart:convert';
import 'package:crypto/crypto.dart';

String digiest(String data) {
  var bytes = utf8.encode(data);
  var digest = sha256.convert(bytes);
  return digest.toString();
}
