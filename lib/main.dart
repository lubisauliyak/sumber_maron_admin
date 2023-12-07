import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/splash_screen.dart';
import 'package:official_sumbermaron/services/prefs_local.dart';
import 'package:official_sumbermaron/utils/decoration_config.dart';
import 'package:official_sumbermaron/utils/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.sp.initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sumber Maron',
      theme: theme(),
      home: const SplashScreen(),
    );
  }
}
