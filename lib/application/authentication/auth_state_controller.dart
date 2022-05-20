import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditations/domain/authentication/auth_value_objects.dart';

import '../../domain/authentication/auth_failures.dart';
import '../../domain/authentication/i_auth_facade.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthStateController extends StateNotifier<AuthStates> {
  AuthStateController(this._authFacade) : super(AuthStates.initial());

  final IAuthFacade _authFacade;

  Future mapEventsToStates(AuthEvents events) async {
    return events.map(
      emailChanged: (value) async {
        state = state.copyWith(
            emailAddress: EmailAddress(
              email: value.email,
            ),
            authFailureOrSuccess: none());
        return null;
      },
      passwordChanged: (value) async {
        state = state.copyWith(
          password: Password(
            password: value.password,
          ),
          authFailureOrSuccess: none(),
        );
        return null;
      },
      signUpWithEmailAndPasswordPressed: (value) async {
        await _performAuthAction(
          _authFacade.registerWithEmailAndPassword,
        );
        return null;
      },
      signInWithEmailAndPasswordPressed: (value) async {
        await _performAuthAction(
          _authFacade.signInWithEmailAndPassword,
        );
        return null;
      },
    );
  }

  Future _performAuthAction(
    Future<Either<AuthFailures, Unit>> Function(
            {required EmailAddress emailAddress, required Password password})
        forwardCall,
  ) async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    Either<AuthFailures, Unit>? failureOrSuccess;
    if (isEmailValid && isPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOrSuccess: none(),
      );
      failureOrSuccess = await forwardCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    state = state.copyWith(
      isSubmitting: false,
      showError: true,
      authFailureOrSuccess: optionOf(failureOrSuccess),
    );
  }
}