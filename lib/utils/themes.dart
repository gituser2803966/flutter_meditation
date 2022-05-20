import 'package:flutter/cupertino.dart';

const kSignupOrSigninBackgroundGColor = Color(0xFFFFFFFF);
const kGetStartedBackgroundGColor = Color(0xFF8E97FD);
const kColorLightYellow = Color(0xFFFFECCC);
const kColorLightGrey = Color(0xFFEBEAEC);
const kColorLight = Color(0xFFFFFFFF);
const kColorDarkGrey = Color(0xFF3F414E);
const kColorGrey = Color(0xFFA1A4B2);
const kPrimaryButtonColor = Color(0xFF8E97FD);
const kFbBackgroundColor = Color(0xFF7583CA); 
const kTextFieldBackgroundColor = Color(0xFFF2F3F7);


class MyThemes {

  static const fontFamily = 'HelveticaNeue';

  static TextStyle thin(double fontSize){
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle medium(double fontSize){
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w500
    );
  }

  static TextStyle bold(double fontSize){
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w700
    );
  }

   static TextStyle black(double fontSize){
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w900
    );
  }

}

extension GetSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}