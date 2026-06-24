import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/sign_in.dart';
import 'auth_dependencies.dart';
import 'auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthInitial();

  Future<void> signIn({required String email, required String password}) async {
    state = const AuthLoading();
    final result = await ref.read(signInProvider)(
      SignInParams(email: email, password: password),
    );
    state = result.fold(
      (failure) => AuthError(failure.message),
      (user) => AuthAuthenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    final result = await ref.read(signOutProvider)(const NoParams());
    state = result.fold(
      (failure) => AuthError(failure.message),
      (_) => const AuthUnauthenticated(),
    );
  }
}
