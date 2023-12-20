import 'package:flutter/material.dart';
import 'package:sumbermaron/utils/size_config.dart';

const kPrimaryColor = Color(0xFF2D68AE);
const kSecondaryColor = Color(0xFF398AB9);
const kGreenColor = Colors.green;
const kRedColor = Colors.red;
const kOrangeColor = Colors.orange;
const kBlackColor = Colors.black;
const kWhiteColor = Colors.white;
const kGreyColor = Colors.grey;

const double sizeAppBar = 15;
const double sizeTitle = 17;
const double sizeText = 13;
const double sizeDescription = 11;

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    colorSchemeSeed: kPrimaryColor,
    fontFamily: "Poppins",
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    labelStyle: const TextStyle(color: kPrimaryColor),
    suffixIconColor: kGreyColor,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding:
        EdgeInsets.symmetric(horizontal: getWidth(25), vertical: getHeight(20)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: kBlackColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: kBlackColor),
    ),
  );
}
