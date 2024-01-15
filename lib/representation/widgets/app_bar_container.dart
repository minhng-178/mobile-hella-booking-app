import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travo_app/core/constants/color_palatte.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';

class AppBArContainerWidget extends StatelessWidget {
  const AppBArContainerWidget(
      {super.key,
      required this.child,
      this.title,
      this.titleString,
      this.implementTraling = false,
      this.implementLeading = false,
      this.paddingContent = const EdgeInsets.symmetric(
        horizontal: kMediumPadding,
      )});

  final Widget child;
  final Widget? title;
  final String? titleString;
  final bool? implementLeading;
  final bool? implementTraling;
  final EdgeInsets? paddingContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 186,
            child: (AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: title ??
                  Row(
                    children: [
                      if (implementLeading != null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(kItemPadding),
                          child: Icon(
                            FontAwesomeIcons.arrowLeft,
                            size: kDefaultPadding,
                            color: Colors.black,
                          ),
                        ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                titleString ?? '',
                                style: TextStyles.defaultStyle.fontHeader
                                    .whiteTextColor.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (implementTraling != null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(kItemPadding),
                          child: Icon(
                            FontAwesomeIcons.bars,
                            size: kDefaultPadding,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: Gradients.defaultGradientBackground,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(35))),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ImageHelper.loadFromAsset(
                      AssetHelper.icoOvalTop,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ImageHelper.loadFromAsset(
                      AssetHelper.icoOvalBottom,
                    ),
                  ),
                ],
              ),
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 156),
            padding: EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: child,
          )
        ],
      ),
    );
  }
}
