import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const routeName = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  final StreamController<int> _pageStreamController =
      StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toInt());
    });
  }

  Widget _buildItemIntroScreen(String image, String title, String description,
      AlignmentGeometry alignmet) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: alignmet,
            child: ImageHelper.loadFromAsset(image,
                height: 400, fit: BoxFit.fitHeight)),
        const SizedBox(
          height: kMediumPadding * 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyles.defaultStyle.bold,
            ),
            Text(
              description,
              style: TextStyles.defaultStyle,
            )
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _pageController,
          children: [
            _buildItemIntroScreen(
                AssetHelper.slide1,
                'Book a flight',
                'Found a flight that matches your destination and schedule? Book it instantly.',
                Alignment.centerRight),
            _buildItemIntroScreen(
                AssetHelper.slide2,
                'Find a hotel room',
                'Select the day, book your room. We give you the best price.',
                Alignment.center),
            _buildItemIntroScreen(
                AssetHelper.slide3,
                'Enjoy your trip',
                'Easy discovering new places and share these between your friends and travel together.',
                Alignment.centerLeft)
          ],
        ),
        Positioned(
          left: kMediumPadding,
          right: kMediumPadding,
          bottom: kMediumPadding * 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotWidth: kMinPadding,
                    dotHeight: kMinPadding,
                    activeDotColor: Colors.orange,
                  ),
                ),
              ),
              StreamBuilder<int>(
                  initialData: 0,
                  stream: _pageStreamController.stream,
                  builder: (context, snapshot) {
                    return Expanded(
                      flex: 4,
                      child: ItemButtonWidget(
                          data: snapshot.data != 2 ? 'Next' : 'Get Started',
                          onTap: () {
                            if (_pageController.page != 2) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut);
                            } else {
                              Navigator.of(context)
                                  .pushNamed(MainApp.routeName);
                            }
                          }),
                    );
                  })
            ],
          ),
        ),
      ]),
    );
  }
}
