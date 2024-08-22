import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late UserProvider _userProvider = UserProvider();
  User? userResult;
  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    initForm();
  }

  Future<void> initForm() async {
    userResult = await _userProvider
        .getById(int.parse(Authentification.tokenDecoded?["Id"]));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(65, 40, 65, 50),
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Column(
                  children: [
                    const Text("Account settings",
                        style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: "username",
                      validator: (value) {
                        if (value == null) {
                          return "Must input username";
                        } else {
                          return null;
                        }
                      },
                      initialValue: userResult!.username!,
                      decoration: customInputDecoration(),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      name: "email",
                      initialValue: userResult!.email!,
                      validator: (value) {
                        if (value == null) {
                          return "Must input email";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Invalid email";
                        } else {
                          return null;
                        }
                      },
                      decoration: customInputDecoration(),
                    ),
                    const SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      name: "birthDate",
                      format: DateFormat('dd/MM/yyyy'),
                      validator: (value) {
                        if (value == null) {
                          return "Must pick a date";
                        } else {
                          return null;
                        }
                      },
                      decoration: customInputDecoration(),
                      initialValue: userResult!.birthDate!,
                      lastDate: DateTime.now(),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState?.save();

                            try {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> request =
                                    Map.of(_formKey.currentState!.value);

                                request['id'] = int.parse(
                                    Authentification.tokenDecoded?["Id"]);

                                request['birthDate'] = dateEncode(
                                    _formKey.currentState?.value['birthDate']);

                                request['role'] = "Administrator";

                                var res = await _userProvider.update(request);

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Successfully updated profile")));
                                }
                              }
                            } on Exception catch (e) {
                              if (mounted) {
                                alertBox(context, "Error", e.toString());
                              }
                            }
                          },
                          child: const Text("Save")),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const SimpleDialog(
                                      children: [ChangePassword()],
                                    ));
                          },
                          child: const Text("Change password")),
                    )
                  ],
                ),
              ),
            ));
  }
}
