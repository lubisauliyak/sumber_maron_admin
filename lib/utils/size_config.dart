import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalBloc;
  static late double verticalBloc;

  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    horizontalBloc = screenWidth / 100;
    verticalBloc = screenHeight / 100;
  }
}

// Get the proportionate height as per screen size
double getProportionateHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  double proportionateHeight;
  // 872 is the layout height that designer use
  double layoutHeightDesigner = 872.0;
  if (screenHeight < layoutHeightDesigner) {
    proportionateHeight = (inputHeight / layoutHeightDesigner) * screenHeight;
  } else if (screenHeight > layoutHeightDesigner * 1.2) {
    proportionateHeight = inputHeight * 1.2;
  } else {
    proportionateHeight = inputHeight;
  }
  return proportionateHeight;
}

// Get the proportionate width as per screen size
double getProportionateWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  double proportionateWidth;
  // 390 is the layout width that designer use
  double layoutWidthDesigner = 390.0;
  if (screenWidth < layoutWidthDesigner) {
    proportionateWidth = (inputWidth / layoutWidthDesigner) * screenWidth;
  } else if (screenWidth > layoutWidthDesigner * 1.2) {
    proportionateWidth = inputWidth * 1.2;
  } else {
    proportionateWidth = inputWidth;
  }
  return proportionateWidth;
}

// Get the proportionate text
double getProportionateText(double inputTextSize) {
  double screenWidth = SizeConfig.screenWidth;
  double proportionateText;
  // 390 is the layout width that designer use
  double layoutWidthDesigner = 390.0;
  if (screenWidth < layoutWidthDesigner) {
    proportionateText = (inputTextSize / 16) * (screenWidth / 24);
  } else if (screenWidth > layoutWidthDesigner * 1.2) {
    proportionateText = inputTextSize * 1.1;
  } else {
    proportionateText = inputTextSize;
  }
  return proportionateText;
}
