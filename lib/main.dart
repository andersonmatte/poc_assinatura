import 'package:flutter/material.dart';
import 'package:poc_assinatura/pages/splash_screen.dart';

void main() => runApp(SignatureApp());

class SignatureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poc Assinatura',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
