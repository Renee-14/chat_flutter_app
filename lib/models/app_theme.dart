
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme{
  MyTheme._();
  static Color kPrimaryColor = Colors.deepPurple.shade900;
  static Color kPrimaryColorVariant = Color(0xff686795);
  static Color kAccentColor = Colors.deepPurple.shade900;
  static Color kAccentColorVariant = Colors.deepPurple.shade900;
  static Color kUnreadChatBG = Color(0xffEE1D1D);

  static final TextStyle kAppTitle= GoogleFonts.satisfy(fontSize: 36);

  static final TextStyle heading2=TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    fontFamily: 'GoogleFonts.tajawal()',
  );

  static final TextStyle chatSenderName=TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1=TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 14,
    letterSpacing: 1.2,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyTextMessage = TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static final TextStyle bodyTextTime=TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    letterSpacing: 1,
    fontWeight: FontWeight.w500,
  );
}