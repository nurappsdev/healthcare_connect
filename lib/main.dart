import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/presentation/pages/login_page.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: await Firebase.initializeApp(options: ...);
  configureDependencies();
  runApp(const ProviderScope(child: HealthcareConnectApp()));
}

class HealthcareConnectApp extends StatelessWidget {
  const HealthcareConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare Connect',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const LoginPage(),
    );
  }
}
