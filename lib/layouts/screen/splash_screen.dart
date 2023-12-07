import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/login_screen.dart';
import 'package:official_sumbermaron/layouts/screen/tiket_screen.dart';
import 'package:official_sumbermaron/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          // MaterialPageRoute(builder: (context) => const LoginScreen()));
          MaterialPageRoute(builder: (context) => const TiketScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: getHeight(20)),
          Hero(
              tag: 'logo-app',
              child: Image.asset(
                'assets/images/smlogo.png',
                height: getHeight(300),
              )),
          Column(
            children: [
              Text('Powered by: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: getHeight(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo_pens.png',
                      height: getHeight(40)),
                  SizedBox(width: getWidth(15)),
                  Image.asset('assets/images/logo_sumbermaron.jpeg',
                      height: getHeight(40)),
                  SizedBox(width: getWidth(15)),
                  Image.asset('assets/images/logo_bumdeskarangsuko.jpeg',
                      height: getHeight(40)),
                  SizedBox(width: getWidth(15)),
                  Image.asset('assets/images/logo_kabmalang.jpeg',
                      height: getHeight(40)),
                ],
              ),
              SizedBox(height: getHeight(20))
            ],
          )
        ],
      ),
    );
  }
}
