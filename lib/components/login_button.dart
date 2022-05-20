import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditations/utils/themes.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.borderColor,
    required this.imagePath,
    this.imageWidth = 13,
    this.imageHeight = 25,
    required this.text,
    required this.textColor,
    required this.fontSize,
    required this.bgColor,
  }) : super(key: key);
  final double buttonWidth;
  final double buttonHeight;
  final Color borderColor;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final String text;
  final Color textColor;
  final double fontSize;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return InkWell(
      onTap: () {},
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.1,
            ),
            SvgPicture.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
            ),
            SizedBox(
              width: size.width * 0.1,
            ),
            Text(
              text,
              style: MyThemes.medium(fontSize).copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
