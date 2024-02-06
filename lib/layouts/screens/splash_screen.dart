import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/layouts/screens/login_screen.dart';
import 'package:sumbermaron_admin/layouts/screens/main_screen.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/preferences_local.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HttpApi dataResponse = HttpApi();

  @override
  void initState() {
    var isRemember = cekAkun();
    if (isRemember) {
      HttpApi.dataHariLibur();
      HttpApi.dataSummaryTiket();
      HttpApi.dataTiketKhusus();
      HttpApi.dataTiketMasuk();
    }
    Future.delayed(const Duration(seconds: 3), () {
      if (isRemember) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Hero(
                    tag: 'logo-app',
                    child: Image.asset('assets/images/smlogo.png',
                        width: getWidth(250))),
              ),
            ),
            Column(
              children: [
                const Text('Didukung oleh: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_pens.png',
                        height: getHeight(40)),
                    SizedBox(width: getWidth(10)),
                    Image.asset('assets/images/logo_sumbermaron.png',
                        height: getHeight(40)),
                    SizedBox(width: getWidth(10)),
                    Image.asset('assets/images/logo_bumdeskarangsuko.png',
                        height: getHeight(40)),
                    SizedBox(width: getWidth(10)),
                    Image.asset('assets/images/logo_kabupatenmalang.png',
                        height: getHeight(40)),
                  ],
                ),
                SizedBox(height: getHeight(50))
              ],
            )
          ],
        ),
      ),
    );
  }
}
