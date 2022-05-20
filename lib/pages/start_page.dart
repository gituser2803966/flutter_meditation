import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditations/components/primary_button.dart';
import 'package:meditations/pages/login_page.dart';
import 'package:meditations/utils/themes.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    return Scaffold(
      backgroundColor: kSignupOrSigninBackgroundGColor,
      body: SafeArea(
        child: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 1,
              child: FittedBox(
                fit: BoxFit.cover,
                //  alignment: Alignment.topCenter,
                // clipBehavior: Clip.antiAlias,
                child: SvgPicture.asset(
                    'assets/images/signin_or_signup_clippath.svg'),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: 0.5,
                widthFactor: 0.9,
                // alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: SvgPicture.asset(
                      'assets/images/signin_or_signup_background.svg'),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                        'assets/images/signin_or_signup_logo.svg'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Align(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'We are what we do',
                                      style: MyThemes.bold(size.height * 0.035)
                                          .copyWith(color: kColorDarkGrey),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text:
                                                'Thousand of people are usign silent moom \n',
                                            style: MyThemes.medium(
                                                    size.height * 0.02)
                                                .copyWith(color: kColorGrey),
                                            children: [
                                              TextSpan(
                                                text: 'for smalls meditation',
                                                style: MyThemes.medium(
                                                        size.height * 0.02)
                                                    .copyWith(
                                                        color: kColorGrey),
                                              ),
                                            ])),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrimaryButton(
                                  text: 'SIGN UP',
                                  textColor: kColorLightGrey,
                                  backgroundColor: kPrimaryButtonColor,
                                  fontSize: size.height * 0.017,
                                  width: size.width * 0.9,
                                  height: size.height * 0.07,
                                  alignment: const Alignment(0, 0),
                                  onPress: () {},
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  LoginPage())));
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'ALREADY HAVE AN ACCOUNT? ',
                                        style:
                                            MyThemes.medium(size.height * 0.017)
                                                .copyWith(color: kColorGrey),
                                        children: [
                                          TextSpan(
                                            text: 'LOG IN',
                                            style: MyThemes.medium(
                                                    size.height * 0.017)
                                                .copyWith(color: kPrimaryButtonColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
