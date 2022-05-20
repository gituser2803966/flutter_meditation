import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditations/utils/themes.dart';

class GetStartedHeader extends StatelessWidget {
  const GetStartedHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Column(children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: SvgPicture.asset('assets/images/ic_logo.svg'),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Align(
            child: FittedBox(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Hi Afsar, Welcome\n',
                  style: MyThemes.medium(34).copyWith(color: kColorLightYellow),
                  children: [
                    TextSpan(
                      text: 'to Silent Moon',
                      style:
                          MyThemes.medium(32).copyWith(color: kColorLightGrey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Align(
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Explore the app, Find some peace of mind to \n',
                  style: MyThemes.thin(18).copyWith(color: kColorLightGrey),
                  children: [
                    TextSpan(
                      text: 'prepare for meditation',
                      style: MyThemes.thin(18).copyWith(color: kColorLightGrey),
                    ),
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
