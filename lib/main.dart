import 'package:flutter/material.dart';
import 'package:ui_kit/theme/app_theme.dart';
import 'package:ui_kit/screens/dashboard_screen.dart';

void main() {
  runApp(const NeuralFlowApp());
}

class NeuralFlowApp extends StatelessWidget {
  const NeuralFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuralFlow Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}
