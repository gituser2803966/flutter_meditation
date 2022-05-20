import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditations/application/authentication/auth_events.dart';
import 'package:meditations/components/login_button.dart';
import 'package:meditations/utils/themes.dart';

import '../application/authentication/auth_state_controller.dart';
import '../application/authentication/auth_states.dart';
import '../services/authentication/firebase_auth_facade.dart';
import '../utils/build_custom_snackbar.dart';
import 'authentication/bottom_nav_page.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<AuthStateController, AuthStates>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseAuthFacade = FirebaseAuthFacade(firebaseAuth);
  return AuthStateController(firebaseAuthFacade);
});

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(loginProvider);
    final events = ref.watch(loginProvider.notifier);

    final size = context.screenSize;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide:
          Divider.createBorderSide(context, color: kTextFieldBackgroundColor),
    );

    ref.listen<AuthStates>(loginProvider, (preStates, nextStates) {
      nextStates.authFailureOrSuccess.fold(
        () {},
        (either) => either.fold(
          (failure) {
            buildCustomSnackBar(
                context: context,
                flashBackground: Colors.red,
                icon: Icons.warning_rounded,
                content: Text(
                  failure.maybeMap(
                      orElse: () => '',
                      emailAlreadyInUse: (value) => 'User already exists',
                      serverError: (value) {
                        return 'Server error occurred';
                      },
                      invalidEmailAndPasswordCombination: (value) {
                        return 'Invalid email or password';
                      }),
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ));
          },
          (success) {
            buildCustomSnackBar(
                context: context,
                flashBackground: Colors.green,
                icon: CupertinoIcons.check_mark_circled_solid,
                content: Text(
                  'Login successful',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ));
            Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ));
          },
        ),
      );
    });

    return Scaffold(
      backgroundColor: kSignupOrSigninBackgroundGColor,
      body: Stack(
        children: [
          // background image
          FractionallySizedBox(
            heightFactor: 0.4,
            widthFactor: 1,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SvgPicture.asset('assets/images/login_clippath.svg'),
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.04, 0.0, size.width * 0.04, 0.0),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                        ),
                                        //Back button
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: SvgPicture.asset(
                                            'assets/images/back_button.svg',
                                            width: size.width * 0.5,
                                            height: size.height * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.04),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Welcome Back!',
                                          style:
                                              MyThemes.bold(size.height * 0.035)
                                                  .copyWith(
                                                      color: kColorDarkGrey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    LoginButton(
                                        buttonWidth: size.width,
                                        buttonHeight: size.height * 0.07,
                                        borderColor: kFbBackgroundColor,
                                        imagePath: 'assets/images/fb_logo.svg',
                                        imageWidth: size.width * 0.07,
                                        imageHeight: size.height * 0.03,
                                        text: 'CONTINUE WITH FACEBOOK',
                                        textColor: kColorLightGrey,
                                        fontSize: size.height * 0.017,
                                        bgColor: kFbBackgroundColor),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    LoginButton(
                                      buttonWidth: size.width,
                                      buttonHeight: size.height * 0.07,
                                      borderColor: kColorGrey,
                                      imagePath:
                                          'assets/images/google_logo.svg',
                                      imageWidth: size.width * 0.07,
                                      imageHeight: size.height * 0.03,
                                      text: 'CONTINUE WITH GOOGLE',
                                      textColor: kColorDarkGrey,
                                      fontSize: size.height * 0.017,
                                      bgColor: kColorLight,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),
                                    Text('OR LOG IN WITH EMAIL',
                                        style:
                                            MyThemes.medium(size.height * 0.015)
                                                .copyWith(color: kColorGrey)),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),

                                    //EmailAddress TextFormField
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (value) => {
                                        events.mapEventsToStates(
                                            AuthEvents.emailChanged(
                                                email: value)),
                                      },
                                      validator: (value) =>
                                          states.emailAddress.valueObject?.fold(
                                              (failure) => failure.maybeMap(
                                                    empty: (value) =>
                                                        "email cannot be empty",
                                                    invalidEmail: (value) =>
                                                        "invalid email",
                                                    orElse: () => null,
                                                  ),
                                              (r) => null),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Email address',
                                        hintStyle:
                                            MyThemes.medium(size.height * 0.018)
                                                .copyWith(color: kColorGrey),
                                        labelStyle:
                                            MyThemes.medium(size.height * 0.018)
                                                .copyWith(color: kColorGrey),
                                        labelText: 'Email address',
                                        border: inputBorder,
                                        focusedBorder: inputBorder,
                                        enabledBorder: inputBorder,
                                        filled: true,
                                        // contentPadding: const EdgeInsets.all(8.0),
                                        fillColor: kTextFieldBackgroundColor,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),

                                    SizedBox(height: size.height * 0.015),

                                    //Password TextFormField
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      onChanged: (value) => {
                                        events.mapEventsToStates(
                                            AuthEvents.passwordChanged(
                                                password: value)),
                                      },
                                      validator: (value) =>
                                          states.password.valueObject!.fold(
                                        (failure) => failure.maybeMap(
                                          empty: (value) => 'password cannot be empty',
                                          shortPassword: (value) =>
                                              'Very short password',
                                          noUpperCase: (value) =>
                                              'Must contain an uppercase character',
                                          noNumber: (value) =>
                                              'Must contain a number',
                                          noSpecialSymbol: (value) =>
                                              'Must contain a special character',
                                          orElse: () => null,
                                        ),
                                        ((r) => null),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle:
                                            MyThemes.medium(size.height * 0.018)
                                                .copyWith(color: kColorGrey),
                                        labelStyle:
                                            MyThemes.medium(size.height * 0.018)
                                                .copyWith(color: kColorGrey),
                                        labelText: 'Password',
                                        border: inputBorder,
                                        focusedBorder: inputBorder,
                                        enabledBorder: inputBorder,
                                        filled: true,
                                        // contentPadding: const EdgeInsets.all(8.0),
                                        fillColor: kTextFieldBackgroundColor,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: true,
                                    ),

                                    SizedBox(height: size.height * 0.02),

                                    //Login button
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          events.mapEventsToStates(const AuthEvents
                                              .signInWithEmailAndPasswordPressed());
                                        }
                                      },
                                      child: const Text('LOG IN'),
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                          Size(size.width, size.height * 0.07),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kPrimaryButtonColor),
                                        textStyle: MaterialStateProperty.all(
                                          MyThemes.medium(size.height * 0.017),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                kColorLight),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Forgot Password?'),
                                      style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            MyThemes.medium(
                                                size.height * 0.017)),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                kColorDarkGrey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    EdgeInsets.only(bottom: size.height * 0.02),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ALREADY HAVE AN ACCOUNT? ',
                                      style:
                                          MyThemes.medium(size.height * 0.015)
                                              .copyWith(color: kColorGrey),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'SIGN UP',
                                        style:
                                            MyThemes.medium(size.height * 0.015)
                                                .copyWith(
                                                    color: kPrimaryButtonColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
