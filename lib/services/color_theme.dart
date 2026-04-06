import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF6936c4);
const Color secondaryColor = Color(0xFFe58861);
const Color tertiaryColor = Color(0xFF9C6BFF);

const Color primaryTextColor = Color(0xFF454b53);
const Color secondaryTextColor = Color(0xFF72695a);

const Color black = Colors.black;
const Color white = Colors.white;
const Color grey = Colors.grey;
const Color red = Colors.red;
const Color green = Colors.green;

const Color softGrey = Color(0XFFD9D9D9);

const List<double> greyCode1 = [0.2126, 0.7152, 0.0722, 0, 0];
const List<double> greyCode2 = [0, 0, 0, 1, 0];
const List<double> listGreyCode = [
  ...greyCode1,
  ...greyCode1,
  ...greyCode1,
  ...greyCode2,
];
const ColorFilter greyscale = ColorFilter.matrix(listGreyCode);
