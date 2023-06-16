import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Storage.dart';
import 'package:medic_petcare/Utils/StorageKey.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getToken() async {
    var tokenAuth = await Storage.get(tokenStorageKey);
    if (tokenAuth != null) {
      await getUserData();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        Routes.loginScreen,
      );
    }
  }

  getUserData() async {
    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).getUser().then((value) {
      if (value['meta']['code'] == 200) {
        Navigator.pushReplacementNamed(
          context,
          Routes.homeScreen,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.loginScreen,
        );
      }
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColor2,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              label: "Coffee Station",
              color: whiteColor,
              type: 's2',
              weight: 'bold',
            ),
          ],
        ),
      ),
    );
  }
}
