import 'package:flutter/material.dart';
import 'package:medic_petcare/Screen/Acccount/AccountScreen.dart';
import 'package:medic_petcare/Screen/Auth/LoginScreen.dart';
import 'package:medic_petcare/Screen/Auth/RegisterScreen.dart';
import 'package:medic_petcare/Screen/Auth/SplashScreen.dart';
import 'package:medic_petcare/Screen/Home/SettingsAccountScreen.dart';
import 'package:medic_petcare/Widgets/BottomNavigationWidget.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static const String splashScreen = 'splashScreen';
  static const String loginScreen = 'loginScreen';
  static const String registerScreen = 'RegisterScreen';
  static const String homeScreen = 'homeScreen';
  static const String accountLandingScreen = 'AccountLandingScreen';
  static const String settingsAccountScreen = 'SettingsAccountScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case loginScreen:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case registerScreen:
        return PageTransition(
          child: const RegisterScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case homeScreen:
        return PageTransition(
          child: BottomNavigationWidget(
            selectedIndex: int.tryParse(settings.arguments.toString()) ?? 0,
          ),
          type: PageTransitionType.rightToLeft,
        );
      case accountLandingScreen:
        return PageTransition(
          child: const AccountLandingScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case settingsAccountScreen:
        return PageTransition(
          child: const SettingsAccountScreen(),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
    }
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text("kosong"),
        ),
      ),
    );
  }
}
