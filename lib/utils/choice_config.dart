import 'package:flutter/material.dart';

final Map<String, Color> statusTextColor = {
  'Lunas': Colors.blue,
  'Belum Lunas': Colors.orange,
  'Menunggu Pembayaran': Colors.red,
};

final Map<String, dynamic> statusBorderColor = {
  'Lunas': Colors.cyan[100],
  'Belum Lunas': Colors.yellow[100],
  'Menunggu Pembayaran': Colors.orange[100],
};

final List<String> dayID = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

final List<String> monthID = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];
