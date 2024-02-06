import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';
import 'package:sumbermaron_admin/utils/size_config.dart';

String digiest(String data) {
  var bytes = utf8.encode(data);
  var digest = sha256.convert(bytes);
  return digest.toString();
}

void cekInternet(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Container(
          padding: EdgeInsets.symmetric(vertical: getHeight(10)),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Koneksi internet?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: Column(
          children: [
            SizedBox(height: getHeight(10)),
            const Text('Pastikan Anda sedang terhubung internet.')
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              'Saya mengerti',
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
