import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:official_sumbermaron/services/secure_http.dart';

class HttpPesanTiket {
  String? statusCode, textMessage, metodeBayar;
  Map<String, dynamic>? data;

  HttpPesanTiket({
    this.statusCode,
    this.textMessage,
    this.metodeBayar,
    this.data,
  });

  static Future<HttpPesanTiket> pesanTiket(
    String jumlahTiket,
    String jenisBayar,
    String tanggalBooking,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1/postTiket');
    String apiKey = getApiKey();
    var dataUser = getDataUser();
    String idUser = dataUser['idUser'];
    final Map<String, dynamic> requestData = {
      'action': 'pesan-tiket',
      'idUser': idUser,
      'jumlahTiket': jumlahTiket,
      'metodeBayar': jenisBayar,
      'tanggalBooking': tanggalBooking,
    };

    var hasilResponse = await http.post(
      url,
      headers: {'ApiKey': apiKey},
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String statusCode = data['statusCode'];
    String textMessage = data['textMessage'];
    String metodeBayar = '';
    Map<String, dynamic> dataPesan = {};
    if (textMessage == 'Pesan tiket berhasil.') {
      metodeBayar = data['metodeBayar'];
      if (metodeBayar == 'Tunai') {
        dataPesan = data['dataTiket'];
      } else {
        dataPesan = data['dataPayment'];
      }
    }

    return HttpPesanTiket(
      statusCode: statusCode,
      textMessage: textMessage,
      metodeBayar: metodeBayar,
      data: dataPesan,
    );
  }
}

class HttpTiketAktif {
  String? statusCode, textMessage, summaryTiket;
  List<Map<String, dynamic>>? dataTiket;

  HttpTiketAktif({
    this.statusCode,
    this.textMessage,
    this.summaryTiket,
    this.dataTiket,
  });

  static Future<HttpTiketAktif> tiketAktif() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1/postTiket');
    String apiKey = getApiKey();
    var dataUser = getDataUser();
    String idUser = dataUser['idUser'];
    final Map<String, dynamic> requestData = {
      'action': 'daftar-tiket-aktif',
      'idUser': idUser,
    };

    var hasilResponse = await http.post(
      url,
      headers: {'ApiKey': apiKey},
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String statusCode = data['statusCode'];
    String textMessage = data['textMessage'];
    String summaryTiket = '';
    List<Map<String, dynamic>> dataTiket = [];
    if (textMessage == 'Daftar tiket aktif ditemukan.') {
      summaryTiket = data['summaryTiket'];
      dataTiket = data['dataTiket'];
    }

    return HttpTiketAktif(
      statusCode: statusCode,
      textMessage: textMessage,
      summaryTiket: summaryTiket,
      dataTiket: dataTiket,
    );
  }
}

class HttpRiwayatTiket {
  String? statusCode, textMessage, summaryTiket;
  List<Map<String, dynamic>>? dataTiket;

  HttpRiwayatTiket({
    this.statusCode,
    this.textMessage,
    this.summaryTiket,
    this.dataTiket,
  });

  static Future<HttpRiwayatTiket> riwayatTiket() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1/postTiket');
    String apiKey = getApiKey();
    var dataUser = getDataUser();
    String idUser = dataUser['idUser'];
    final Map<String, dynamic> requestData = {
      'action': 'daftar-riwayat-tiket',
      'idUser': idUser,
    };

    var hasilResponse = await http.post(
      url,
      headers: {'ApiKey': apiKey},
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String statusCode = data['statusCode'];
    String textMessage = data['textMessage'];
    String summaryTiket = '';
    List<Map<String, dynamic>> dataTiket = [];
    if (textMessage == 'Daftar tiket aktif ditemukan.') {
      summaryTiket = data['summaryTiket'];
      dataTiket = data['dataTiket'];
    }

    return HttpRiwayatTiket(
      statusCode: statusCode,
      textMessage: textMessage,
      summaryTiket: summaryTiket,
      dataTiket: dataTiket,
    );
  }
}
