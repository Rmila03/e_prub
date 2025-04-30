import 'package:flutter/material.dart';
import '../../presentation/pages/welcome_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/register_page.dart';
import '../../presentation/pages/forgot_password_page.dart';
import '../../presentation/pages/main_navigation_page.dart';
import '../../presentation/pages/workshop_profile_page.dart';
import '../../presentation/pages/quotations_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/welcome': (_) => const WelcomePage(),
  '/login': (_) => const LoginPage(),
  '/register': (_) => const RegisterPage(),
  '/forgot_password': (_) => const ForgotPasswordPage(),
  '/main': (_) => const MainNavigationPage(),
  '/workshop_profile': (_) => const WorkshopProfilePage(),
  '/quotations': (_) => const QuotationsPage(),
};
