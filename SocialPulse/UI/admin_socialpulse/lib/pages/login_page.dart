import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/access_provider.dart';
import '../utils/utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AccessProvider _accessProvider = AccessProvider();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _accessProvider = context.read<AccessProvider>();
  }

  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Container(
                height: size.height * 0.24,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1E2E3D),
                      Color(0xff152534),
                      Color(0xff0C1C2E),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign in to your Account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextFormField(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                      ),
                      AppTextFormField(
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        controller: _passwordController,
                        obscureText: isObscure,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(48, 48),
                              ),
                            ),
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      isLoading
                          ? const SpinKitFadingCircle(color: Colors.lightGreen)
                          : FilledButton(
                              onPressed: () async {
                                var email = _emailController.text;
                                var password = _passwordController.text;

                                if (email.isEmpty) {
                                  alertBox(context, "Validation Error",
                                      "Email cannot be blank");
                                } else if (!AppConstants.emailRegex
                                    .hasMatch(email)) {
                                  alertBox(context, "Validation Error",
                                      "Invalid email address");
                                } else if (password.isEmpty) {
                                  alertBox(context, "Validation Error",
                                      "Password cannot be blank");
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                  }

                                  try {
                                    var data = await _accessProvider.signIn(
                                        email, password);
                                    var token = data['token'];
                                    Authentification.token = token;
                                    Authentification.tokenDecoded =
                                        JwtDecoder.decode(token);

                                    if (Authentification
                                            .tokenDecoded?['Role'] !=
                                        'Administrator') {
                                      if (mounted) {
                                        alertBox(context, "Error",
                                            "User account cannot access desktop app");
                                      }
                                      if (mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const HomePage();
                                        }));
                                      }
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text("Error"),
                                                content: Text(e.toString()),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        if (mounted) {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }
                                                      },
                                                      child: const Text('Ok'))
                                                ],
                                              ));
                                    }
                                  }
                                }
                              },
                              child: const Text('Login'),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static Color primaryColor = const Color(0xffBAE162);
  static const lightBlue = Color(0xff1E2E3D);
  static const blue = Color(0xff152534);
  static const darkBlue = Color(0xff0C1C2E);
  static const grey = Color(0xffE8EAEC);
}

class AppConstants {
  AppConstants._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  // static final RegExp passwordRegex = RegExp(
  //   r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
  // );
}

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.textInputAction,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
    super.key,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.onEditingComplete,
    this.autofocus,
    this.focusNode,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String labelText;
  final bool? autofocus;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: autofocus ?? false,
        validator: validator,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          errorStyle: const TextStyle(color: Colors.teal),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}

extension ContextExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;

  void showSnackBar(String? message, {bool isError = false}) =>
      ScaffoldMessenger.of(this)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message ?? ''),
          ),
        );
}
