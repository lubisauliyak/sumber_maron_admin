import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sumbermaron/services/preferences_local.dart';
import 'package:sumbermaron/services/secure_http.dart';

class HttpApi {
  String? textMessage;
  Map<String, dynamic>? bodyResponse;

  HttpApi({
    this.textMessage,
    this.bodyResponse,
  });

  static Future<HttpApi> loginUser(
    String email,
    String kataSandi,
  ) async {
    final password = digiest(kataSandi);

    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    final Map<String, dynamic> requestData = {
      'action': 'login-user',
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
      Map<String, dynamic> dataPengguna = data['dataUser'];
      List<dynamic> dataBanner = data['dataBanner'];
      List<dynamic> dataHariLibur = data['dataHariLibur'];
      Map<String, dynamic> dataLokasiParkir = data['dataLokasiParkir'];

      simpanAkun(dataPengguna);
      simpanBanner(dataBanner);
      simpanHariLibur(dataHariLibur);
      simpanLokasiParkir(dataLokasiParkir);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataBanner() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    var dataPengguna = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'data-banner',
      'idUser': dataPengguna['idUser']
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data banner didapatkan') {
      List<dynamic> dataBanner = data['dataBanner'];
      simpanBanner(dataBanner);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataLokasiParkir() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');

    final Map<String, dynamic> requestData = {'action': 'data-lokasi-parkir'};

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data lokasi parkir didapatkan') {
      Map<String, dynamic> dataLokasiParkir = data['dataLokasiParkir'];
      simpanLokasiParkir(dataLokasiParkir);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> dataHariLibur() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');

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

  static Future<HttpApi> registrasiUser(
    String nama,
    String telepon,
    String email,
    String kataSandi,
  ) async {
    String password = digiest(kataSandi);

    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    final Map<String, dynamic> requestData = {
      'action': 'registrasi-user',
      'nama': nama,
      'telepon': telepon,
      'email': email,
      'password': password
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

  static Future<HttpApi> editUser(
    String nama,
    String telepon,
    String email,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    var dataPengguna = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'edit-user',
      'idUser': dataPengguna['idUser'],
      'nama': nama,
      'telepon': telepon,
      'email': email
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

  static Future<HttpApi> pesanTiket(
    String tanggalBooking,
    String jumlahPengunjung,
    String metodeBayar,
    String jumlahTiket,
    String diskonTiket,
    String hargaTiket,
    String weekTiket,
    String totalBayar,
    String namaPromo,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    var dataPengguna = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'pesan-tiket',
      'idUser': dataPengguna['idUser'],
      'tanggalBooking': tanggalBooking,
      'jumlahPengunjung': jumlahPengunjung,
      'metodeBayar': metodeBayar,
      'jumlahTiket': jumlahTiket,
      'diskonTiket': diskonTiket,
      'hargaTiket': hargaTiket,
      'weekTiket': weekTiket,
      'totalBayar': totalBayar,
      'namaPromo': namaPromo,
    };

    var hasilResponse = await http.post(url, body: json.encode(requestData));

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> bayarPayment(
    String idTiket,
    String statusPayment,
  ) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');

    final Map<String, dynamic> requestData = {
      'action': 'bayar-payment',
      'idTiket': idTiket,
      'statusPayment': statusPayment,
    };

    var hasilResponse = await http.post(url, body: json.encode(requestData));

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> recreatePayment(String idTiket) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');

    final Map<String, dynamic> requestData = {
      'action': 'recreate-payment',
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

  static Future<HttpApi> tiketAktif() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    var dataPengguna = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'data-tiket-aktif',
      'idUser': dataPengguna['idUser']
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data tiket aktif ditemukan') {
      List<dynamic> dataTiketAktif = data['dataTiket'];
      simpanTiketAktif(dataTiketAktif);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }

  static Future<HttpApi> riwayatTiket() async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1.2/postUser');
    var dataPengguna = muatAkun();

    final Map<String, dynamic> requestData = {
      'action': 'data-riwayat-tiket',
      'idUser': dataPengguna['idUser']
    };

    var hasilResponse = await http.post(
      url,
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String textMessage = data['textMessage'];
    if (textMessage == 'Data riwayat tiket ditemukan') {
      List<dynamic> dataRiwayatTiket = data['dataTiket'];
      simpanRiwayatTiket(dataRiwayatTiket);
    }

    return HttpApi(
      textMessage: textMessage,
      bodyResponse: data,
    );
  }
}
