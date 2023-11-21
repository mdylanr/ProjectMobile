import 'package:flutter/material.dart';
import 'package:medic_petcare/Provider/ProductProvider.dart';
import 'package:medic_petcare/Provider/UserProvider.dart';
import 'package:medic_petcare/Routes/Routes.dart';
import 'package:medic_petcare/Screen/Product/DetailProductScreen.dart';
import 'package:medic_petcare/Utils/Images.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/ProductCardWidget.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/LoadingWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).home();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileSection(),
                  Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return value.isLoading
                          ? const CircleLoadingWidget()
                          : value.getHome['popular']['data'].isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        bottom: defaultMargin,
                                        left: defaultMargin,
                                        right: defaultMargin,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget(
                                            label: "Produk Populer",
                                            type: 's3',
                                            weight: 'bold',
                                            color: fontPrimaryColor,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.homeScreen,
                                                arguments: 1,
                                              );
                                            },
                                            child: TextWidget(
                                              label: "Lihat Semua",
                                              weight: 'bold',
                                              type: 'b2',
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 190,
                                      child: ListView.builder(
                                        itemCount: value
                                            .getHome['popular']['data'].length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                          left: defaultMargin,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProductScreen(
                                                    data:
                                                        value.getHome['popular']
                                                            ['data'][index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ProductCardWidget(
                                              data: value.getHome['popular']
                                                  ['data'][index],
                                              isHorizontal: true,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                    },
                  ),
                  Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return value.isLoading
                          ? const CircleLoadingWidget()
                          : value.getHome['news']['data'].isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 24,
                                        left: defaultMargin,
                                        right: defaultMargin,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextWidget(
                                            label: "Produk Terbaru",
                                            type: 's3',
                                            weight: 'bold',
                                            color: fontPrimaryColor,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.homeScreen,
                                                arguments: 1,
                                              );
                                            },
                                            child: TextWidget(
                                              label: "Lihat Semua",
                                              weight: 'bold',
                                              type: 'b2',
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 24,
                                      ),
                                      child: ListView.builder(
                                        itemCount: value
                                            .getHome['news']['data'].length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          left: defaultMargin,
                                          right: defaultMargin,
                                          bottom: 24,
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProductScreen(
                                                    data: value.getHome['news']
                                                        ['data'][index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ProductCardWidget(
                                              data: value.getHome['news']
                                                  ['data'][index],
                                              isHorizontal: false,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        var user = value.getUserData;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ImageWidget(
                        image: getPhotoUrl(
                          user['avatar'] ?? "",
                        ),
                        width: double.infinity,
                      ),
                    ),
                  ),
                  ImageWidget(
                    image: notifIcon,
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: defaultMargin,
              ),
              TextWidget(
                label: "Selamat Datang,",
                type: 'b2',
                color: fontSecondaryColor,
              ),
              const SizedBox(
                height: 2,
              ),
              TextWidget(
                label: user['name'],
                type: 's2',
                weight: 'bold',
                color: fontPrimaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
