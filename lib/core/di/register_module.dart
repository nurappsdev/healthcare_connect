import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

/// Provides third-party dependencies that injectable cannot construct itself.
@module
abstract class RegisterModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
