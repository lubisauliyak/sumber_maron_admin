import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:official_sumbermaron/layouts/screen/riwayat_screen.dart';

class PaymentFailedPopup extends StatefulWidget {
  const PaymentFailedPopup({super.key});

  @override
  State<PaymentFailedPopup> createState() => _PaymentFailedPopupState();
}

class _PaymentFailedPopupState extends State<PaymentFailedPopup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Payment Failed',
          desc: 'Maaf Pembayaran Anda Gagal',
          btnOkOnPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RiwayatScreen();
                },
              ),
            );
          },
          btnOkColor: Colors.red,
          btnOkText: 'Close')
        ..show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
