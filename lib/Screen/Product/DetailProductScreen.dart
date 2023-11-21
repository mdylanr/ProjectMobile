import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medic_petcare/Utils/Snackbar.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/ButtonWidget.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProductScreen extends StatefulWidget {
  final Map data;
  const DetailProductScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                flexibleSpace: FlexibleSpaceBar(
                  background: ImageWidget(
                    image: getPhotoUrl(widget.data['image'] ?? ""),
                    width: double.infinity,
                  ),
                ),
                backgroundColor: whiteColor,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(
                    0.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      defaultMargin,
                      24,
                      defaultMargin,
                      defaultMargin,
                    ),
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
                  padding: EdgeInsets.fromLTRB(
                    defaultMargin,
                    0,
                    defaultMargin,
                    defaultMargin,
                  ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextWidget(
                              label: widget.data['name'],
                              color: fontPrimaryColor,
                              weight: 'bold',
                              type: 's3',
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                color: fontSecondaryColor,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                label: widget.data['view'],
                                type: 'l1',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () async {
                          var lat = widget.data['lattitude'];
                          var long = widget.data['longitude'];
                          String mapUrl =
                              "https://www.google.com/maps/search/?api=1&query=$lat,$long";
                          if (await canLaunchUrl(Uri.parse(mapUrl))) {
                            await launchUrl(
                              Uri.parse(mapUrl),
                            );
                          } else {
                            showSnackBar(
                              context,
                              "",
                              type: "error",
                              subtitle: "Tidak dapat membuka URL: $mapUrl",
                              position: "TOP",
                              duration: 2,
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: fontSecondaryColor,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  TextWidget(
                                    label: widget.data['address'],
                                    type: 'l1',
                                  ),
                                ],
                              ),
                            ),
                            TextWidget(
                              label: formatPrice(
                                amount: widget.data['price'],
                              ),
                              weight: 'bold',
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 10,
                        color: borderColor,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextWidget(
                        label: "Deskripsi",
                        weight: 'medium',
                        color: fontPrimaryColor,
                      ),
                      Html(
                        data: widget.data['description'],
                        style: {
                          "body": defaultHtmlStyle.copyWith(
                            fontSize: const FontSize(14),
                            padding: const EdgeInsets.only(bottom: 16),
                          ),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: defaultMargin,
            right: defaultMargin,
            child: Column(
              children: [
                ButtonWidget(
                  title: "Pesan Sekarang",
                  onPressed: () async {
                    var message = Uri.encodeComponent(
                        'Halo kak, Barang ${widget.data['name']} masih ready?');
                    var whatsappUrl =
                        "whatsapp://send?phone=6282234702123" "&text=$message";
                    launch(whatsappUrl);
                  },
                ),
                // const SizedBox(height: 10), // Spacing between buttons
                // ButtonWidget(
                //   title: "Lokasi Sekarang",
                //   onPressed: () {
                //     // Handle button pressed action for "Lokasi Sekarang" button
                //     // Add your code here
                //   },
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
