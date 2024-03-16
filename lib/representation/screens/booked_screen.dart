import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:travo_app/api/api_payments.dart';
import 'package:travo_app/models/payment_model.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/providers/auth_user_provider.dart';
import 'package:travo_app/representation/screens/login_screen.dart';
import 'package:travo_app/representation/screens/tours_screen.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_booking_history.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_elevated_button.dart';

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});

  static const String routeName = '/booked_screen';

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthUserProvider>(context);
    final isLoggedIn = userProvider.isLoggedIn;

    return AppBarContainerWidget(
      titleString: 'Payment History',
      implementLeading: false,
      implementTraling: true,
      child: isLoggedIn
          ? _buildPaymentHistory() // Show payment history if logged in
          : _buildLoginPrompt(), // Show login prompt otherwise
    );
  }

  Widget _buildPaymentHistory() {
    ApiPayment apiPayment = ApiPayment();

    return FutureBuilder<List<PaymentModel>>(
      future: apiPayment.getPaymentHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while fetching data
          return Center(
            child: CircularProgressIndicator(
              color: ColorPalette.primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error case
          return Center(
            child: Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // User has payment history, display it
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!
                  .map(
                    (e) => ItemBookingHistory(paymentModel: e),
                  )
                  .toList(),
            ),
          );
        } else {
          // User is new (no payment history)
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don't have any payment history.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                ItemElevatedButton(
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    Navigator.of(context).pushNamed(ToursScreen.routeName);
                  },
                  title: 'Start Booking Tour',
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please log in to view payment history.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ItemButtonWidget(
            onTap: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
            data: 'Log In',
          ),
        ],
      ),
    );
  }
}
