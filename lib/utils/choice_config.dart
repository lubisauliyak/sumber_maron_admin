import 'package:intl/intl.dart';
import 'package:sumbermaron/utils/decoration_config.dart';

final Map<String, dynamic> statusBorderColor = {
  'Lunas': kGreenColor,
  'Belum Lunas': kRedColor,
  'Menunggu Pembayaran': kOrangeColor,
  'Berhasil': kGreenColor,
  'Dibatalkan Sistem': kRedColor,
};

final Map<String, dynamic> statusTextColor = {
  'Lunas': kGreenColor,
  'Belum Lunas': kRedColor,
  'Menunggu Pembayaran': kOrangeColor,
  'Berhasil': kGreenColor,
  'Dibatalkan Sistem': kRedColor,
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

String formatTanggalIndonesia(String inputTanggal) {
  DateTime parsedTanggal = DateTime.parse(inputTanggal);

  String hari = dayID[parsedTanggal.weekday - 1];
  String tanggal = parsedTanggal.day.toString();
  String bulan = monthID[parsedTanggal.month - 1];
  String tahun = parsedTanggal.year.toString();
  String formattedTanggal = '$hari, $tanggal $bulan $tahun';

  return formattedTanggal;
}

String formatRupiah(String inputBayar) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  return currencyFormatter.format(int.parse(inputBayar));
}
