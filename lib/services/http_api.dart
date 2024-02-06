import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/services/secure_http.dart';

class HttpApi {
  String? textMessage;
  Map<String, dynamic>? bodyResponse;

  HttpApi({
    this.textMessage,
    this.bodyResponse,
  });

  static Future<HttpApi> loginAdmin(
    String email,
    String kataSandi,
  ) async {
    final password = digiest(kataSandi);

    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');
    final Map<String, dynamic> requestData = {
      'action': 'login-admin',
      'email': email,
      'password': password
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Login berhasil') {
      Map<String, dynamic> dataAdmin = data['dataAdmin'];
      List<dynamic> dataHariLibur = data['dataHariLibur'];
      List<dynamic> dataSummaryTiket = data['dataSummaryTiket'];

      simpanAkun(dataAdmin);
      simpanHariLibur(dataHariLibur);
      simpanSummary(dataSummaryTiket);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataHariLibur() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');

    final Map<String, dynamic> requestData = {'action': 'data-hari-libur'};

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data hari libur didapatkan') {
      List<dynamic> dataHariLibur = data['dataHariLibur'];
      simpanHariLibur(dataHariLibur);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataSummaryTiket() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');

    final Map<String, dynamic> requestData = {'action': 'data-summary-tiket'};

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data summary tiket didapatkan') {
      List<dynamic> dataSummaryTiket = data['dataSummaryTiket'];
      simpanSummary(dataSummaryTiket);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> scanTiket(String kodeQr) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');

    final Map<String, dynamic> requestData = {
      'action': 'scan-tiket',
      'kodeQr': kodeQr,
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> editTiket(
    String idTiket,
    String jumlahPengunjung,
    String jumlahTiket,
    String diskonTiket,
    String totalBayar,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');
    var dataAdmin = muatAkun();

    final Map<dynamic, dynamic> requestData = {
      'action': 'edit-tiket',
      'idAdmin': dataAdmin['idAdmin'],
      'idTiket': idTiket,
      'jumlahPengunjung': jumlahPengunjung,
      'jumlahTiket': jumlahTiket,
      'diskonTiket': diskonTiket,
      'totalBayar': totalBayar
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> rescheduleTiket(
    String idTiket,
    String tanggalBooking,
    String hargaTiket,
    String weekTiket,
    String totalBayar,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');
    final Map<String, dynamic> requestData = {
      'action': 'reschedule-tiket',
      'idTiket': idTiket,
      'tanggalBooking': tanggalBooking,
      'hargaTiket': hargaTiket,
      'weekTiket': weekTiket,
      'totalBayar': totalBayar,
    };

    var hasilResponse = await http.post(url, body: json.encode(requestData));

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> hapusTiket(
    String idTiket,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');
    final Map<String, dynamic> requestData = {
      'action': 'hapus-tiket',
      'idTiket': idTiket,
    };

    var hasilResponse = await http.post(url, body: json.encode(requestData));

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> tukarTiket(String idTiket, String metodeBayar) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');
    var dataAdmin = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'tukar-tiket',
      'idAdmin': dataAdmin['idAdmin'],
      'idTiket': idTiket,
      'metodeBayar': metodeBayar
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> tiketKonvensional(
    String jumlahPengunjung,
    String jumlahTiket,
    String diskonTiket,
    String hargaTiket,
    String weekTiket,
    String totalBayar,
    String metodeBayar,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');
    var dataAdmin = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'tiket-konvensional',
      'idAdmin': dataAdmin['idAdmin'],
      'namaPengunjung': '',
      'teleponPengunjung': '',
      'jumlahPengunjung': jumlahPengunjung,
      'jumlahTiket': jumlahTiket,
      'diskonTiket': diskonTiket,
      'hargaTiket': hargaTiket,
      'weekTiket': weekTiket,
      'totalBayar': totalBayar,
      'metodeBayar': metodeBayar
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataTiketKhusus() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');

    final Map<String, dynamic> requestData = {'action': 'data-tiket-khusus'};

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data tiket khusus ditemukan') {
      List<dynamic> dataTiket = data['dataTiket'];
      simpanTiketKhusus(dataTiket);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataTiketMasuk() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v2/postAdmin');

    final Map<String, dynamic> requestData = {'action': 'data-tiket-masuk'};

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data tiket masuk ditemukan') {
      List<dynamic> dataTiket = data['dataTiket'];
      simpanTiketMasuk(dataTiket);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }
}
