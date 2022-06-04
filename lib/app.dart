import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meditations/pages/authentication/bottom_nav_page.dart';
import 'package:meditations/pages/start_page.dart';

//check user is logged in or not
final checkUserIsLogged = StreamProvider.autoDispose<User?>((ref) async* {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> user = _firebaseAuth.authStateChanges();
  yield* user;
});

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(checkUserIsLogged);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user.when(
        data: (value) => const AuthPage(),
        loading: () => const CircularProgressIndicator(
          color: Colors.black38,
        ),
        error: (e, stack) => const StartPage(),
      ),
    );
  }
}
