import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/representation/services/notifi_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:travo_app/representation/screens/payment_success.dart';

class WebviewPaymentScreen extends StatefulWidget {
  const WebviewPaymentScreen({super.key, required this.paymentUrl});

  static const String routeName = '/payment_method_screen';

  final String paymentUrl;

  @override
  State<WebviewPaymentScreen> createState() => _WebviewPaymentScreenState();
}

class _WebviewPaymentScreenState extends State<WebviewPaymentScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (url.startsWith('https://booking-tour-zeta.vercel.app')) {
              var uri = Uri.parse(url);
              var queryString = uri.query;
              NotificationService().showNotification(
                  title: 'Payment Success!', body: 'Enjoy your trip. ❤️');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PaymentSuccessScreen(queryString: queryString),
                ),
              );
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding * 3),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
