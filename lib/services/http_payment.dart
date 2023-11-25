import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:official_sumbermaron/services/secure_http.dart';

class HttpBayarPayment {
  String? statusCode, textMessage;
  Map<String, dynamic>? dataTiket;

  HttpBayarPayment({
    this.statusCode,
    this.textMessage,
    this.dataTiket,
  });

  static Future<HttpBayarPayment> bayarPayment(String idTiket,
      String idTiketDigital, String idPayment, String statusPayment) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1/postPayment');
    String apiKey = getApiKey();
    var dataUser = getDataUser();
    String idUser = dataUser['idUser'];
    final Map<String, dynamic> requestData = {
      'action': 'bayar-payment',
      'idUser': idUser,
      'idTiket': idTiket,
      'idTiketDigital': idTiketDigital,
      'idPayment': idPayment,
      'statusPayment': statusPayment,
    };

    var hasilResponse = await http.post(
      url,
      headers: {'ApiKey': apiKey},
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String statusCode = data['statusCode'];
    String textMessage = data['textMessage'];
    Map<String, dynamic> dataTiket = {};
    if (textMessage == 'Pembayaran diterima.') {
      dataTiket = data['dataTiket'];
    }

    return HttpBayarPayment(
      statusCode: statusCode,
      textMessage: textMessage,
      dataTiket: dataTiket,
    );
  }
}
