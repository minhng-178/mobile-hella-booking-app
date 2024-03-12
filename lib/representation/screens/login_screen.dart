import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:travo_app/api/api_auth.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/representation/screens/register_screen.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';
import 'package:travo_app/representation/widgets/item_square_title_widget.dart';
import 'package:travo_app/representation/widgets/item_textfield_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() async {
    if (_formKey.currentState!.validate()) {
      ApiAuth apiAuth = ApiAuth();
      apiAuth
          .signIn(
              emailController.text, passwordController.text, _formKey, context)
          .then((_) => apiAuth.checkTokens());
    }
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

    //But not this
    print(googleAuth?.idToken);

    //  apiAuth.verifyTokenGoogle(idToken);

    return userCredential;
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: 'Login',
      child: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
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
                const SizedBox(height: 10),
                ItemTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ItemButtonWidget(
                  data: 'Login',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
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
                const SizedBox(height: 50),

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
                    ItemSquareTitle(
                      imagePath: AssetHelper.apple,
                      onTap: signOutGoogle,
                    )
                  ],
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
