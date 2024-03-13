import 'package:flutter/material.dart';

import 'package:travo_app/api/api_payments.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_empty_section.dart';
import 'package:travo_app/representation/widgets/item_subtitle.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key, required this.queryString});

  static const String routeName = '/payment_success_screen';

  final String queryString;
  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  final List<String> steps = [
    'Book and Review',
    'Payment',
    'Confirm',
  ];

  int currentStep = 2;

  void _handleReturnIpn() {
    ApiPayment apiPayment = ApiPayment();
    apiPayment.returnIpn(widget.queryString, context);
  }

  Widget _buildItemCheckOutStep(
    int step,
    String nameStep,
    bool isEnd,
    bool isCheck,
  ) {
    return Row(
      children: [
        Container(
          width: kMediumPadding,
          height: kMediumPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kMediumPadding),
            color: isCheck ? Colors.white : Colors.white.withOpacity(0.1),
          ),
          alignment: Alignment.center,
          child: Text(
            step.toString(),
            style: TextStyles.defaultStyle.copyWith(
              color: isCheck ? null : Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: kMinPadding,
        ),
        Text(nameStep,
            style: TextStyles.defaultStyle.fontCaption.whiteTextColor),
        SizedBox(
          width: kMinPadding,
        ),
        if (!isEnd)
          SizedBox(
            width: kDefaultPadding,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.white,
            ),
          ),
        if (!isEnd)
          SizedBox(
            width: kMinPadding,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Payment Success',
      implementLeading: false,
      implementTraling: true,
      child: Column(children: [
        Row(
          children: steps
              .map((e) => _buildItemCheckOutStep(
                  steps.indexOf(e) + 1,
                  e,
                  steps.indexOf(e) == steps.length - 1,
                  steps.indexOf(e) <= currentStep))
              .toList(),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: kMinPadding,
                ),
                ItemEmptySection(
                  emptyImg: AssetHelper.success,
                  emptyMsg: 'Successful !!',
                ),
                ItemSubTitle(
                  subTitleText: 'Your payment was done successfully',
                ),
                ItemButtonWidget(
                  data: 'Continue',
                  onTap: _handleReturnIpn,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
