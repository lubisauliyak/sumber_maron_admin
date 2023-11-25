import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:official_sumbermaron/services/prefs_local.dart';
import 'package:official_sumbermaron/services/secure_http.dart';

class HttpLogin {
  String? statusCode, textMessage;

  HttpLogin({
    this.statusCode,
    this.textMessage,
  });

  static Future<HttpLogin> loginUser(String input, String password) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1/postUser');
    String apiKeyGlobal = getApiKeyGlobal();
    String pass = digiest(password);
    final Map<String, dynamic> requestData = {
      'action': 'login-user',
      'input': input,
      'password': pass
    };

    var hasilResponse = await http.post(
      url,
      headers: {'ApiKey': apiKeyGlobal},
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);
    String statusCode = data['statusCode'];
    String textMessage = data['textMessage'];
    if (textMessage == 'Login berhasil.') {
      var dataUser = data['dataUser'];
      var jsonData = json.encode(dataUser);
      SPHelper.sp.save('userData', jsonData);
    }

    return HttpLogin(
      statusCode: statusCode,
      textMessage: textMessage,
    );
  }
}

class HttpDaftar {
  String? statusCode, textMessage;

  HttpDaftar({this.statusCode, this.textMessage});

  static Future<HttpDaftar> daftarUser(String nama, String username,
      String telepon, String email, String password) async {
    Uri url = Uri.parse('https://app.sumbermaron.site/v1/postUser');
    String apiKey = getApiKey();
    String pass = digiest(password);
    final Map<String, dynamic> requestData = {
      'action': 'daftar-user',
      'nama': nama,
      'username': username,
      'telepon': telepon,
      'email': email,
      'password': pass
    };

    var hasilResponse = await http.post(
      url,
      headers: {'ApiKey': apiKey},
      body: json.encode(requestData),
    );

    var data = json.decode(hasilResponse.body);

    return HttpDaftar(
      statusCode: data['statusCode'],
      textMessage: data['textMessage'],
    );
  }
}
