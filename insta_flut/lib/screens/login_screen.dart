import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_flut/resources/auth_methods.dart';
import 'package:insta_flut/responsive/mobile_screen_layout.dart';
import 'package:insta_flut/responsive/responsive_layout_screen.dart';
import 'package:insta_flut/responsive/web_screen_layout.dart';
import 'package:insta_flut/screens/signup_screen.dart';
import 'package:insta_flut/utils/colors.dart';
import 'package:insta_flut/utils/global_variable.dart';
import 'package:insta_flut/utils/utils.dart';
import 'package:insta_flut/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenlayout(),
            webScreenLayout: WebScreenlayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              //text field input for email
              TextFieldInput(
                textEditingController: _emailController,
                textInputType: TextInputType.text,
                hintText: 'Enter your Email',
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for password
              TextFieldInput(
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                hintText: 'Enter your Password',
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //button login
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Log in'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Transitioning to signing up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: const Text("Don't have an account? "),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      )),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
