import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medic_petcare/Provider/ProductProvider.dart';
import 'package:medic_petcare/Screen/Product/DetailProductScreen.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Widgets/LoadingWidget.dart';
import 'package:medic_petcare/Widgets/ProductCardWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ProductLandingScreen extends StatefulWidget {
  const ProductLandingScreen({Key? key}) : super(key: key);

  @override
  State<ProductLandingScreen> createState() => _ProductLandingScreenState();
}

class _ProductLandingScreenState extends State<ProductLandingScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 24,
              horizontal: defaultMargin,
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    label: "Daftar Produk",
                    type: 's3',
                    weight: 'bold',
                    color: fontPrimaryColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextWidget(
                    label: "Berikut adalah daftar semua produk unggulan kami",
                    color: fontSecondaryColor,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  value.isLoading
                      ? const CircleLoadingWidget()
                      : AlignedGridView.count(
                          crossAxisCount: 2,
                          itemCount: value.getProducts.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          mainAxisSpacing: defaultMargin,
                          crossAxisSpacing: defaultMargin,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductScreen(
                                      data: value.getProducts[index],
                                    ),
                                  ),
                                );
                              },
                              child: ProductCardWidget(
                                data: value.getProducts[index],
                                isHorizontal: false,
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
