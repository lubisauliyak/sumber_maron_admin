import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:official_sumbermaron/layouts/screen/tiket_screen.dart';

class PaymentSuccessPopup extends StatefulWidget {
  const PaymentSuccessPopup({super.key});

  @override
  State<PaymentSuccessPopup> createState() => _PaymentSuccessPopupState();
}

class _PaymentSuccessPopupState extends State<PaymentSuccessPopup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Payment',
        desc: 'Selamat pembayaran berhasil dilakukan.',
        btnOkOnPress: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return TiketScreen();
          }));
        },
      )..show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
