import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travo_app/api/api_auth.dart';
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
    ApiAuth apiAuth = ApiAuth();
    apiAuth.register(
        emailController.text,
        nameController.text,
        passwordController.text,
        phoneController.text,
        gender,
        _formKey,
        context);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    ApiAuth apiAuth = ApiAuth();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    String? idToken = await userCredential.user!.getIdToken();

    apiAuth
        .verifyTokenGoogle(idToken, context)
        .then((_) => apiAuth.checkTokens());

    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    bool isNumeric(String str) {
      return double.tryParse(str) != null;
    }

    return AppBarContainerWidget(
      titleString: 'Sign Up',
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
                  children: [
                    // google button
                    ItemSquareTitle(
                      imagePath: AssetHelper.google,
                      onTap: signInWithGoogle,
                    ),

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
