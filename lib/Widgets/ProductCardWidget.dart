import 'package:flutter/material.dart';
import 'package:medic_petcare/Utils/Themes.dart';
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/Widgets/ImageWidget.dart';
import 'package:medic_petcare/Widgets/TextWidget.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isHorizontal;
  final String type;
  const ProductCardWidget({
    Key? key,
    required this.data,
    this.isHorizontal = false,
    this.type = 'home',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == 'home'
        ? Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: blackColor.withOpacity(.3),
            color: whiteColor,
            child: Container(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: isHorizontal
                        ? MediaQuery.of(context).size.width * .65
                        : double.infinity,
                    clipBehavior: Clip.hardEdge,
                    height: isHorizontal ? 120 : 180,
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: ImageWidget(
                      image: getPhotoUrl(data['image'] ?? ""),
                      height: isHorizontal ? 120 : 180,
                      width: isHorizontal
                          ? MediaQuery.of(context).size.width * .80
                          : double.infinity,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                      left: 6,
                      right: 6,
                      bottom: 6,
                    ),
                    width: isHorizontal
                        ? MediaQuery.of(context).size.width * .65 - 32
                        : MediaQuery.of(context).size.width * .85,
                    child: TextWidget(
                      label: data['name'],
                      color: fontPrimaryColor,
                      weight: 'medium',
                      maxLines: 2,
                      useEllipsis: true,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: blackColor.withOpacity(.3),
            color: whiteColor,
            child: Container(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: isHorizontal
                        ? MediaQuery.of(context).size.width * .65
                        : double.infinity,
                    clipBehavior: Clip.hardEdge,
                    height: isHorizontal ? 120 : 180,
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: ImageWidget(
                      image: getPhotoUrl(data['image'] ?? ""),
                      height: isHorizontal ? 120 : 180,
                      width: isHorizontal
                          ? MediaQuery.of(context).size.width * .80
                          : double.infinity,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                      left: 6,
                      right: 6,
                      bottom: 6,
                    ),
                    width: isHorizontal
                        ? MediaQuery.of(context).size.width * .65 - 32
                        : MediaQuery.of(context).size.width * .85,
                    child: TextWidget(
                      label: data['name'],
                      color: fontPrimaryColor,
                      weight: 'medium',
                      maxLines: 2,
                      useEllipsis: true,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
