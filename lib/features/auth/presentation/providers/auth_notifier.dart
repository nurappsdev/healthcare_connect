import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import 'auth_state.dart';

/// Riverpod replacement for the old AuthBloc.
///
/// Usecases are pulled from get_it lazily (only inside the methods), so simply
/// watching this provider does not construct the Firebase-backed chain.
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthInitial();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AuthLoading();
    final result = await getIt<SignIn>()(
      SignInParams(email: email, password: password),
    );
    state = result.fold(
      (failure) => AuthError(failure.message),
      (user) => AuthAuthenticated(user),
    );
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    final result = await getIt<SignOut>()(const NoParams());
    state = result.fold(
      (failure) => AuthError(failure.message),
      (_) => const AuthUnauthenticated(),
    );
  }
}
