import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../providers/access_provider.dart';

import 'package:mobile_socialpulse/pages/login_page.dart';

import '../utils/utils.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormBuilderState>();
  late AccessProvider _accessProvider = AccessProvider();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _accessProvider = context.read<AccessProvider>();

    initForm();
  }

  Future<void> initForm() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      alertBoxMoveBack(
          context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              height: size.height * 0.24,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightBlue,
                    AppColors.blue,
                    AppColors.darkBlue,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Create your account',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FormBuilderTextField(
                    name: "username",
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "Must input value";
                      } else {
                        return null;
                      }
                    }),
                    decoration: const InputDecoration(
                      label: Text("Username"),
                      floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                  ),
                  const SizedBox(height: 10,),
                  FormBuilderTextField(
                    name: 'email',
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "Must input email";
                      } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Invalid email";
                      } else {
                        return null;
                      }
                    }),
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                  ),
                  const SizedBox(height: 10,),
                FormBuilderDateTimePicker(
                  name: 'birthDate',
                  validator: (value) {
                    if (value == null) {
                      return "Mandatory field";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text("Birth date"),
                      floatingLabelBehavior: FloatingLabelBehavior.always
                )),
                const SizedBox(height: 10,),

                  FormBuilderTextField(
                    name: 'password',
                    obscureText: true,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "Must input value";
                      } else if (value.length < 8 ||
                          !value.contains(RegExp(r'[A-Z]')) ||
                          !value.contains(RegExp(r'[a-z]')) ||
                          !value.contains(RegExp(r'[0-9]'))) {
                        return "Password has to contain at least 8 characters, lowercase and uppercase letters and numbers.";
                      } else {
                        return null;
                      }
                    }),
                    decoration: const InputDecoration(
                      label:
                      Text("Password"),
                      floatingLabelBehavior: FloatingLabelBehavior.always
                    ),
                  ),
                  const SizedBox(height: 10,),
                  FilledButton(
                      onPressed: () async {
                        try {
                          _formKey.currentState?.save();
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> request =
                            Map.of(_formKey.currentState!.value);

                            request['birthDate'] = dateEncode(_formKey
                                .currentState?.value['birthDate']);

                            request['isActive'] = true;

                            await _accessProvider.signUp(request);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Successfully signed up!")));

                            Navigator.pop(context);
                          } else {}
                        } catch (e) {
                          alertBox(
                              context,
                              "Error",
                              e.toString());
                        }
                      },
                      child: const Text("Sign up"))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I have an account?',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



