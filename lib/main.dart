import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/colors.dart';
import 'core/theme/app_routes.dart';

void main() {
  runApp(const FabChainApp());
}

class FabChainApp extends StatelessWidget {
  const FabChainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FabChain',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: AppColors.textPrimaryColor,
            displayColor: AppColors.textSecondaryColor,
          ),
        ),
      ),
      initialRoute: '/welcome',
      routes: appRoutes,
    );
  }
}
