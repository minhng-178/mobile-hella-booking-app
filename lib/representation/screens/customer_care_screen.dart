import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';

class CustomerCareScreen extends StatefulWidget {
  const CustomerCareScreen({super.key});

  static const String routeName = '/customer_care';

  @override
  State<CustomerCareScreen> createState() => _CustomerCareScreenState();
}

class _CustomerCareScreenState extends State<CustomerCareScreen> {
  final _formKey = GlobalKey<FormState>();
  String feedback = '';

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Customer Care',
      implementTraling: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Phone: 123-456-7890',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: support@example.com',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'FAQs',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Q: How do I reset my password?',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'A: Click on "Forgot Password" at the login screen and follow the instructions.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Feedback',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  maxLines: 5,
                  onChanged: (value) {
                    setState(() {
                      feedback = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your feedback',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
