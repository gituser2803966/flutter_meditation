import 'package:flutter/material.dart';
import 'package:meditations/components/get_started_background.dart';
import 'package:meditations/components/get_started_header.dart';
import 'package:meditations/utils/themes.dart';

import '../components/primary_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Stack(
      children: [
        const GetStartedHeader(),
        const GetStartedBackground(),
        PrimaryButton(
          text: 'SIGN UP',
          textColor: kColorLightGrey,
          backgroundColor: kPrimaryButtonColor,
          fontSize: size.height * 0.02,
          width: size.width * 0.8,
          height: size.height * 0.07,
          alignment: const Alignment(0, 0),
          onPress: (){},
        )
      ],
    );
  }
}
