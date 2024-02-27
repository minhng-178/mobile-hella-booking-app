import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/providers/auth_provider.dart';
import 'package:travo_app/representation/screens/login_screen.dart';
import 'package:travo_app/representation/screens/register_screen.dart';
import 'package:travo_app/representation/widgets/item_drawer_widget.dart';

class AppBarContainerWidget extends StatelessWidget {
  const AppBarContainerWidget(
      {super.key,
      required this.child,
      this.title,
      this.titleString,
      this.subTitleString,
      this.implementTraling = false,
      this.implementLeading = true,
      this.paddingContent = const EdgeInsets.symmetric(
        horizontal: kMediumPadding,
      )})
      : assert(title != null || titleString != null,
            'title or title String can\'t be null');

  final Widget child;
  final Widget? title;
  final String? titleString;
  final String? subTitleString;
  final bool implementTraling;
  final bool implementLeading;
  final EdgeInsets? paddingContent;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = userProvider.isLoggedIn;
    final isLoginPage =
        ModalRoute.of(context)?.settings.name == LoginScreen.routeName;
    final isRegisterPage =
        ModalRoute.of(context)?.settings.name == RegisterScreen.routeName;

    return Scaffold(
      endDrawer: ItemDrawer(),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: 186,
                child: AppBar(
                  actions: <Widget>[Container()],
                  title: title ??
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (implementLeading)
                              (GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          kDefaultPadding),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(kItemPadding),
                                  child: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    size: kDefaultPadding,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (titleString ?? ''),
                                      style: TextStyles.defaultStyle.fontHeader
                                          .whiteTextColor.bold,
                                    ),
                                    if (subTitleString != null)
                                      (Padding(
                                        padding: const EdgeInsets.only(
                                            top: kMediumPadding),
                                        child: Text(
                                          subTitleString!,
                                          style: TextStyles.defaultStyle
                                              .fontCaption.whiteTextColor,
                                        ),
                                      ))
                                  ],
                                ),
                              ),
                            ),
                            if (implementTraling && isLoggedIn)
                              GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          kDefaultPadding),
                                      color: Colors.white),
                                  padding: EdgeInsets.all(kItemPadding),
                                  child: ImageHelper.loadFromAsset(
                                      AssetHelper.icoMenu),
                                ),
                              )
                            else if (!isLoggedIn &&
                                !isLoginPage &&
                                !isRegisterPage)
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(LoginScreen
                                      .routeName); // Navigate to the login screen
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyles
                                      .defaultStyle.bold.whiteTextColor,
                                ),
                              )
                          ],
                        ),
                      ),
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: Gradients.defaultGradientBackground,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                          ),
                        ),
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
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  toolbarHeight: 150,
                  backgroundColor: ColorPalette.backgroundScaffoldColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 156),
                padding: paddingContent,
                child: child,
              )
            ],
          ),
        );
      }),
    );
  }
}
