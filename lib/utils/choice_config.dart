import 'package:intl/intl.dart';
import 'package:sumbermaron_admin/utils/decoration_config.dart';

final Map<String, dynamic> statusBorderColor = {
  'Lunas': kGreenColor,
  'Belum Lunas': kRedColor,
};

final Map<String, dynamic> statusTextColor = {
  'Lunas': kGreenColor,
  'Belum Lunas': kRedColor,
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

String formatWIB(String inputWaktu) {
  return '${inputWaktu.substring(0, 5)} WIB';
}

String formatRupiah(String inputBayar) {
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  return currencyFormatter.format(int.parse(inputBayar));
}

List<String> formatWeekTiket(String inputTanggal, List inputHariLibur) {
  var week = 'Hari Kerja';
  var harga = '5000';
  DateTime parsedTanggal = DateTime.parse(inputTanggal);
  String hari = dayID[parsedTanggal.weekday - 1];
  if (inputHariLibur.contains(inputTanggal)) {
    week = 'Hari Libur';
    harga = '10000';
  } else if (hari == 'Sabtu' || hari == 'Minggu') {
    week = 'Akhir Pekan';
    harga = '10000';
  }

  return [week, harga];
}
