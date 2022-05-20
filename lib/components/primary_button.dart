import 'package:flutter/material.dart';
import 'package:meditations/utils/themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key, 
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.fontSize,
      required this.width,
      required this.height,
      required this.alignment, 
      required this.onPress,
       }): super(key: key);
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double width;
  final double height; 
  final double fontSize;
  final Alignment alignment;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
          fixedSize: MaterialStateProperty.all(Size(width, height)),
          foregroundColor: MaterialStateProperty.all(textColor),
          textStyle: MaterialStateProperty.all(
            MyThemes.medium(fontSize).copyWith(color: textColor)
          ),
        ),
      ),
    );
  }
}
