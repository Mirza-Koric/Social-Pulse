import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  final User? user;

  const UserDetails({this.user, super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(children: [
            const Text("User details", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            FormBuilderTextField(
                name: "id",
                initialValue:
                    widget.user == null ? "0" : widget.user!.id.toString(),
                enabled: false),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Email"),
              name: "email",
              initialValue: widget.user == null ? "" : widget.user!.email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input email";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Username"),
              name: "username",
              initialValue: widget.user == null ? "" : widget.user!.username,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input username";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            widget.user == null
                ? FormBuilderTextField(
                    name: "password",
                    decoration: customInputDecoration(hint: "Password"),
                    validator: (value) {
                      if (value == null) {
                        return "Must input password";
                      } else {
                        return null;
                      }
                    },
                  )
                : const SizedBox(),
            widget.user == null ? const SizedBox(height: 10) : const SizedBox(),
            FormBuilderDropdown<String>(
                decoration: customInputDecoration(),
                name: "role",
                items: const [
                  DropdownMenuItem(
                      value: "Administrator", child: Text("Administrator")),
                  DropdownMenuItem(value: "User", child: Text("User"))
                ],
                initialValue: widget.user == null ? "User" : widget.user!.role),
            const SizedBox(height: 10),
            FormBuilderDateTimePicker(
              name: "birthDate",
              format: DateFormat('dd/MM/yyyy'),
              decoration: customInputDecoration(),
              initialValue:
                  widget.user == null ? DateTime.now() : widget.user!.birthDate,
              validator: (value) {
                if (value == null) {
                  return "Must input date";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            Row(children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close")),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      _formKey.currentState?.save();
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> request =
                            Map.of(_formKey.currentState!.value);

                        request['birthDate'] = dateEncode(
                            _formKey.currentState?.value['birthDate']);

                        if (widget.user == null) {
                          await _userProvider.insert(request);
                        } else if (widget.user != null) {
                          await _userProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Successfully added/updated user")));
                          Navigator.pop(context, "refresh");
                        }
                      }
                    } catch (e) {
                      if (mounted) {
                        alertBox(context, "Error", e.toString());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  ))
            ])
          ]),
        ),
      ),
    );
  }
}
