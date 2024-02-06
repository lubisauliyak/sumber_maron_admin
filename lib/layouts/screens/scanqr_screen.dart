import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sumbermaron_admin/layouts/partials/detail_tiket_scan.dart';
import 'package:sumbermaron_admin/layouts/partials/qrscanner_overlay.dart';
import 'package:sumbermaron_admin/services/http_api.dart';
import 'package:sumbermaron_admin/services/secure_http.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  HttpApi dataResponse = HttpApi();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controllerCamera;
  bool isCameraOn = false;
  String kodeQr = '';

  @override
  void initState() {
    if (Platform.isAndroid) {
      isCameraOn = true;
    }
    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        isCameraOn = false;
      });
    });
    super.initState();
  }

  void _onQRViewCreated(QRViewController controller) {
    _controllerCamera = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.stopCamera();
      setState(() {
        kodeQr = scanData.code!;
      });
      if (kodeQr != '') {
        HttpApi.scanTiket(kodeQr).then((value) {
          dataResponse = value;
          if (dataResponse.textMessage == 'Tiket valid') {
            Map<String, dynamic> dataTiket =
                dataResponse.bodyResponse!['dataTiket'];
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailTiketScan(dataTiket: dataTiket)));
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Container(
                      padding: EdgeInsets.symmetric(vertical: getHeight(10)),
                      decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('QR Code salah?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    content: Column(children: [
                      SizedBox(height: getHeight(10)),
                      Text(dataResponse.textMessage ?? '')
                    ]),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(
                          'Tutup',
                          style: TextStyle(
                              color: kRedColor, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        }).catchError((error) {
          cekInternet(context);
        });
      }
    });
  }

  @override
  void dispose() {
    _controllerCamera?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              CupertinoIcons.left_chevron,
              color: kWhiteColor,
            )),
        backgroundColor: kPrimaryColor,
        title: const Text(
          'QR Code Tiket',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  setState(() {
                    isCameraOn = !isCameraOn;
                  });
                }
                if (isCameraOn) {
                  Future.delayed(const Duration(seconds: 20), () {
                    setState(() {
                      isCameraOn = false;
                    });
                  });
                }
              },
              icon: Icon(
                isCameraOn ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                color: kWhiteColor,
              ))
        ],
      ),
      body: SafeArea(
        child: Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              isCameraOn
                  ? QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/camera_off.png',
                          height: getWidth(150),
                        ),
                        SizedBox(height: getHeight(5)),
                        const Text(
                          'Tekan Di Sini',
                          style: TextStyle(fontSize: sizeDescription),
                        ),
                        const Text(
                          'Untuk menghidupkan Kamera',
                          style: TextStyle(fontSize: sizeDescription),
                        )
                      ],
                    ),
              GestureDetector(
                onTap: () {
                  if (isCameraOn == false) {
                    setState(() {
                      isCameraOn = true;
                    });
                    Future.delayed(const Duration(seconds: 20), () {
                      setState(() {
                        isCameraOn = false;
                      });
                    });
                  }
                },
                child: QRScannerOverlay(
                  overlayColour: kPrimaryColor.withOpacity(0.2),
                ),
              ),
              Positioned(
                top: getHeight(30),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(30), vertical: getHeight(5)),
                  decoration: BoxDecoration(
                    color: isCameraOn
                        ? kWhiteColor.withOpacity(.5)
                        : kWhiteColor.withOpacity(0),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: kWhiteColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Tempatkan QR Code di dalam area',
                        style: TextStyle(
                            color: isCameraOn ? kPrimaryColor : kBlackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: getHeight(5)),
                      Text(
                        'Pemindaian dimulai secara otomatis',
                        style: TextStyle(
                            color: isCameraOn ? kPrimaryColor : kBlackColor,
                            fontSize: sizeDescription),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
