import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron/layouts/partials/detail_tiket_aktif.dart';
import 'package:sumbermaron/services/http_api.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sumbermaron/layouts/screens/main_screen.dart';
import 'package:sumbermaron/utils/decoration_config.dart';
import 'package:sumbermaron/utils/size_config.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SnapMidtrans extends StatefulWidget {
  const SnapMidtrans({
    Key? key,
    required this.idTiket,
    required this.linkPayment,
  }) : super(key: key);

  final String idTiket;
  final String linkPayment;

  @override
  State<SnapMidtrans> createState() => _SnapMidtransState();
}

class _SnapMidtransState extends State<SnapMidtrans> {
  HttpApi dataResponse = HttpApi();

  late WebViewController? _controllerSnapMidtrans;

  var isFinished = false;
  Map<String, dynamic> dataTiket = {};

  @override
  void initState() {
    super.initState();
    _controllerSnapMidtrans = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (url.contains('status_code=202&transaction_status=deny')) {
              HttpApi.bayarPayment(widget.idTiket, 'Deny');
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Pembayaran Gagal',
                      desc:
                          'Maaf, pembayaran Anda gagal diselesaikan dan belum diterima.',
                      btnOkOnPress: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                const MainScreen(pilihScreen: 1)));
                      },
                      btnOkColor: kRedColor,
                      btnOkText: 'Tutup')
                  .show();
              setState(() {
                isFinished = true;
              });
            }
            if (url.contains('status_code=200&transaction_status=settlement')) {
              HttpApi.bayarPayment(widget.idTiket, 'Settlement').then((value) {
                dataResponse = value;
                setState(() {
                  dataTiket = dataResponse.bodyResponse!['dataTiket'];
                });
              });
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'Pembayaran Berhasil',
                      desc:
                          'Selamat, pembayaran Anda berhasil dilakukan dan telah diterima.',
                      btnOkOnPress: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => DetailTiketAktif(
                                dataTiket: dataTiket, fromSnapMidtrans: true)));
                      },
                      btnOkColor: kPrimaryColor,
                      btnOkText: 'Tutup')
                  .show();
              setState(() {
                isFinished = true;
              });
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.sumbermaron.site/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.linkPayment));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                isFinished
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MainScreen(pilihScreen: 1)))
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Container(
                              padding:
                                  EdgeInsets.symmetric(vertical: getHeight(10)),
                              decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('Keluar halaman ini?',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            content: Column(children: [
                              SizedBox(height: getHeight(10)),
                              const Text('Pembayaran tiket Anda belum selesai.')
                            ]),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text(
                                  'Selesaikan',
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(
                                      color: kRedColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen(
                                                  pilihScreen: 1)));
                                },
                              )
                            ],
                          );
                        });
              },
              icon: const Icon(
                CupertinoIcons.left_chevron,
                color: kWhiteColor,
              )),
          title: const Text(
            'Pembayaran Non Tunai',
            style: TextStyle(color: kWhiteColor),
          ),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
          child: _controllerSnapMidtrans != null
              ? WebViewWidget(controller: _controllerSnapMidtrans!)
              : const CircularProgressIndicator(),
        ));
  }
}
