import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Utils/Images.dart';
import 'package:medic_petcare/Utils/Snackbar.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/ButtonWidget.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/InputWidget.dart';
import 'package:medic_petcare/Widgets/ModalOptionWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errEmail = "", errPassword = "";
  bool isLoading = false;
  handleSubmit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool valid = true;
    setState(() {
      errEmail = "";
      errPassword = "";
      isLoading = true;
    });
    if (emailController.text.isEmpty) {
      errEmail = "Email wajib diisi";
      valid = false;
    }
    if (passwordController.text.isEmpty) {
      errPassword = "Password wajib diisi";
      valid = false;
    }
    if (valid) {
      await Provider.of<UserProvider>(
        context,
        listen: false,
      ).login(
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      ).then((value) {
        if (value['meta']['code'] == 200) {
          Navigator.pushReplacementNamed(
            context,
            Routes.homeScreen,
          );
        } else {
          setState(() {
            showSnackBar(
              context,
              value["meta"]['message'],
              type: 'error',
              position: 'TOP',
              duration: 1,
            );
          });
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  onChangeEmail(String newText) {
    if (emailController.text.isNotEmpty && newText.isNotEmpty) {
      setState(() {
        errEmail = "";
      });
    } else {
      setState(() {
        errEmail = "Email wajib diisi";
      });
    }
  }

  onChangePassword(String newText) {
    if (passwordController.text.isNotEmpty && newText.isNotEmpty) {
      setState(() {
        errPassword = "";
      });
    } else {
      setState(() {
        errPassword = "Password wajib diisi";
      });
    }
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
              textAlign: TextAlign.center,
              axisText: CrossAxisAlignment.center,
              alignmentText: Alignment.center,
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
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 292,
              flexibleSpace: FlexibleSpaceBar(
                background: ImageWidget(
                  image: backgroundLogin,
                  width: double.infinity,
                ),
              ),
              backgroundColor: whiteColor,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(
                  0.0,
                ),
                child: Container(
                  padding:
                      EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 32),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                        25,
                      ),
                    ),
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 32),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(
                      25,
                    ),
                  ),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    TextWidget(
                      label: "Coffee Station",
                      type: 's1',
                      color: primaryColor,
                      weight: 'bold',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InputWidget(
                      title: "Email",
                      hintText: "Masukkan Alamat Email",
                      controller: emailController,
                      errText: errEmail,
                      type: TextInputType.emailAddress,
                      onChanged: onChangeEmail,
                    ),
                    InputWidget(
                      title: "Password",
                      hintText: "Masukkan Password",
                      obscure: true,
                      controller: passwordController,
                      errText: errPassword,
                      onChanged: onChangePassword,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 24,
                      ),
                      width: double.infinity,
                      child: ButtonWidget(
                        title: "Masuk",
                        isLoading: isLoading,
                        theme: isLoading ? 'disable' : 'primary',
                        onPressed: () async {
                          handleSubmit();
                        },
                      ),
                    ),
                    Divider(
                      height: 24,
                      color: borderColor,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        title: "Daftar",
                        type: 'outline',
                        theme: isLoading ? 'disable' : 'primary',
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            Routes.registerScreen,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
