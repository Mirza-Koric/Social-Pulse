import 'package:admin_socialpulse/pages/login_page.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late UserProvider _userProvider = UserProvider();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(65, 80, 65, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Change Password", style: TextStyle(fontSize: 24)),
                const SizedBox(
                  height: 30,
                ),
                FormBuilderTextField(
                  name: "password",
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be blank.";
                    }
                    return null;
                  }),
                  decoration: customInputDecoration(hint: "Password"),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormBuilderTextField(
                  name: "newPassword",
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "New password cannot be blank.";
                    } else if (value.length < 8 ||
                        !value.contains(RegExp(r'[A-Z]')) ||
                        !value.contains(RegExp(r'[a-z]')) ||
                        !value.contains(RegExp(r'[0-9]'))) {
                      return "Password has to contain at least 8 characters, lowercase and uppercase letters and numbers.";
                    } else {
                      return null;
                    }
                  }),
                  decoration: customInputDecoration(hint: "New Password"),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormBuilderTextField(
                  name: "confirmPassword",
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "New Password cannot be blank";
                    } else if (value !=
                        _formKey.currentState?.value['newPassword']) {
                      return "New password and confirm password must match.";
                    } else {
                      return null;
                    }
                  }),
                  decoration: customInputDecoration(hint: "Confirm Password"),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState?.save();

                      try {
                        if (_formKey.currentState!.validate()) {
                          var res = await _userProvider.changePassword({
                            'id': Authentification.tokenDecoded?['Id'],
                            'password':
                                _formKey.currentState?.value['password'],
                            'newPassword':
                                _formKey.currentState?.value['newPassword'],
                            'confirmNewPassword':
                                _formKey.currentState?.value['confirmPassword']
                          });

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Password successfully changed")));

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()),
                                (route) => false);
                          }
                        }
                      } catch (e) {
                        if (mounted) {
                          alertBox(
                              context,
                              "Error",
                              e.toString().contains("Credentials")
                                  ? "Incorrect old password."
                                  : e.toString());
                        }
                      }
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
