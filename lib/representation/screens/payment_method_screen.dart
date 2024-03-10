import 'package:flutter/material.dart';
import 'package:travo_app/api/api_payments.dart';

import 'package:travo_app/models/booking_model.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/representation/screens/payment_success.dart';
import 'package:travo_app/representation/widgets/dash_line.dart';
import 'package:travo_app/core/constants/textstyle_constants.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_header_label.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_dropdown_language.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({
    super.key,
    required this.bookingModel,
  });

  static const String routeName = '/payment_method_screen';

  final BookingModel bookingModel;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? value = 'VNBANK';
  String? language;
  final descController = TextEditingController();

  final paymentValues = ['VNBANK', 'INTCARD'];

  final paymentLabels = [
    'Thanh toán qua ATM-Tài khoản ngân hàng nội địa',
    'Thanh toán qua thẻ quốc tế'
  ];

  final paymentIcons = [
    AssetHelper.napas,
    AssetHelper.visa,
  ];

  final List<String> steps = [
    'Book and Review',
    'Payment',
    'Confirm',
  ];

  int currentStep = 1;

  void _handleCreatePayment() {
    ApiPayment apiPayment = ApiPayment();

    apiPayment.createPayment(
        widget.bookingModel.id, value, language, descController.text);
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
      titleString: 'Payment',
      implementTraling: true,
      child: Column(
        children: [
          Row(
            children: steps
                .map((e) => _buildItemCheckOutStep(
                    steps.indexOf(e) + 1,
                    e,
                    steps.indexOf(e) == steps.length - 1,
                    steps.indexOf(e) <= currentStep))
                .toList(),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemHeaderLabel(
                  headerText: 'Choose your payment method:',
                ),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Radio<String>(
                            activeColor: ColorPalette.primaryColor,
                            value: paymentValues[index],
                            groupValue: value,
                            onChanged: (String? newValue) {
                              setState(() {
                                value = newValue;
                              });
                            },
                          ),
                          title: Text(
                            paymentLabels[index],
                            style: TextStyle(color: ColorPalette.text1Color),
                          ),
                          trailing:
                              ImageHelper.loadFromAsset(paymentIcons[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return DashLineWidget();
                      },
                      itemCount: paymentLabels.length),
                ),
                ItemHeaderLabel(
                  headerText: 'Choose your language:',
                ),
                ItemDropdownLanguage(
                  value: language,
                  onChanged: (String? newValue) {
                    setState(() {
                      language = newValue;
                    });
                  },
                ),
                ItemHeaderLabel(
                  headerText: 'Description:',
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: TextField(
                    controller: descController,
                    style: TextStyles.defaultStyle.regular,
                    maxLines: 8, //or null
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your text here"),
                  ),
                ),
                ItemButtonWidget(data: 'Submit', onTap: _handleCreatePayment)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
