import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallet App',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}