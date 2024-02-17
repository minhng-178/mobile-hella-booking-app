import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_dropdown_widget.dart';
import 'package:travo_app/representation/widgets/item_square_title_widget.dart';
import 'package:travo_app/representation/widgets/item_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  String? gender;

  final _formKey = GlobalKey<FormState>();

  void signUserUp() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // Prepare data to send
      Map<String, String> headers = {"Content-type": "application/json"};
      Uri url = Uri.parse("https://hella-booking.onrender.com/api/v1/signUp");
      var body = json.encode({
        'email': emailController.text,
        'name': nameController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'gender': gender,
      });

      // Send the request
      var response = await http.post(url, headers: headers, body: body);
      // Do something with the response
      if (response.statusCode == 200) {
        log('User signed up successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User signed up successfully')),
        );
      } else {
        var errorResponse = json.decode(response.body);
        log('Server error: ${errorResponse['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to sign up user: ${errorResponse['message']}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNumeric(String str) {
      return double.tryParse(str) != null;
    }

    return AppBArContainerWidget(
      titleString: 'Sign Up',
      isLoggedIn: true,
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      'Let’s create your account!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    ItemTextField(
                        controller: emailController,
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        obscureText: false),
                    const SizedBox(height: 15),
                    ItemTextField(
                        controller: nameController,
                        hintText: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        obscureText: false),
                    const SizedBox(height: 15),
                    ItemTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 15),
                    ItemTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 15),
                    ItemTextField(
                      controller: phoneController,
                      hintText: 'Phone',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!isNumeric(value)) {
                          // Assuming isNumeric is a function that checks if a string is numeric
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    const SizedBox(height: 15),
                    ItemDropdown(
                      value: gender,
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'By tapping sign up you agree to the',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Term and Condition',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'and ',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' of this app',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ItemButtonWidget(
                  data: 'Sign up',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    ItemSquareTitle(imagePath: AssetHelper.google),

                    SizedBox(width: 25),

                    // apple button
                    ItemSquareTitle(imagePath: AssetHelper.apple)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
