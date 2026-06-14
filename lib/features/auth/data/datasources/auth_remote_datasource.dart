import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw ServerException('Sign in returned no user');
      }
      return UserModel(
        uid: user.uid,
        email: user.email ?? email,
        displayName: user.displayName,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Authentication failed');
    }
  }

  @override
  Future<void> signOut() => firebaseAuth.signOut();
}
