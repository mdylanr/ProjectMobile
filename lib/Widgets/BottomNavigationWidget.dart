import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medic_petcare/Screen/Acccount/AccountScreen.dart';

import 'package:medic_petcare/Screen/Home/HomeScreen.dart';
import 'package:medic_petcare/Screen/Product/ProductLandingScreen.dart';

import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ModalOptionWidget.dart';

class BottomNavigationWidget extends StatefulWidget {
  int selectedIndex = 0;

  BottomNavigationWidget({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const ProductLandingScreen(),
    const AccountLandingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  onPressBottomTop() async {
    exit(0);
  }

  onPressButtonBottom() async {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ModalOptionWidget(
              title: "Konfirmasi",
              subtitle: "Apakah anda yakin ingin keluar dari aplikasi?",
              titleButtonTop: 'Iya',
              titleButtonBottom: 'Tidak',
              onPressButtonTop: onPressBottomTop,
              onPressButtonBottom: onPressButtonBottom,
              imageTopHeight: 125,
              textAlign: TextAlign.left,
              axisText: CrossAxisAlignment.start,
              alignmentText: Alignment.centerLeft,
            );
          },
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: _pages.elementAt(widget.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          selectedFontSize: 12,
          selectedItemColor: fontPrimaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          currentIndex: widget.selectedIndex, //New
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: "Produk",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: "Akun",
            ),
          ],
        ),
      ),
    );
  }
}

Widget getIcon(icon) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      minHeight: 24,
    ),
    child: Image.asset(
      icon,
      width: 24,
      fit: BoxFit.cover,
    ),
  );
}
