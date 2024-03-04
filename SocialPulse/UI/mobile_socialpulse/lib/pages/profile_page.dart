import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mobile_socialpulse/pages/chats_page.dart';
import 'package:mobile_socialpulse/pages/login_page.dart';
import 'package:mobile_socialpulse/pages/qnA_page.dart';
import 'package:mobile_socialpulse/pages/subscription_page.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  bool editing = false;

  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider = UserProvider();
  User? userResult;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      userResult = await _userProvider
          .getById(int.parse(Authentification.tokenDecoded?["Id"]));

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : Scaffold(
            backgroundColor: const Color(0xFFEAF2F4),
            body: GestureDetector(
              onTap: () {
                if (editing) {
                  setState(() {
                    editing = false;
                  });
                  _formKey.currentState?.reset();
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                if (editing) {
                                  try {
                                    _formKey.currentState?.save();

                                    if (_formKey.currentState!.validate()) {
                                      Map<String, dynamic> request =
                                          Map.of(_formKey.currentState!.value);

                                      request['id'] = int.parse(
                                          Authentification.tokenDecoded?["Id"]);

                                      request['birthDate'] = dateEncode(_formKey
                                          .currentState?.value['birthDate']);

                                      await _userProvider.update(request);

                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Successfully updated profile")));
                                      }
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      alertBox(context, "Error", e.toString());
                                    }
                                  }
                                }
                                fetchData();
                                setState(() {
                                  editing = !editing;
                                });
                              },
                              child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.lime,
                                  ),
                                  width: screenWidth * 0.30,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 28),
                                      child: Icon(
                                        editing ? Icons.save : Icons.edit,
                                        color: const Color(0xFF444444),
                                        size: 32,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.7,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF8c981a),
                            ),
                            child: const Center(
                              child: Text(
                                "Your profile",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFFFFF3E5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5.0),
                          child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        color: Color(0xFF8C981A),
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10.0),
                                      editing
                                          ? Expanded(
                                              child: FormBuilderTextField(
                                                name: 'username',
                                                validator: (value) {
                                                  if (value == null) {
                                                    return "Must input username";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                initialValue:
                                                    userResult!.username!,
                                                decoration:
                                                    customInputDecoration(),
                                              ),
                                            )
                                          : Text(
                                              userResult!.username!,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF444444)),
                                            )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.mail_outline,
                                        color: Color(0xFF8C981A),
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10.0),
                                      //I chose to swap text widget with textField widget
                                      // because it was easier to deal with decorations
                                      editing
                                          ? Expanded(
                                              child: FormBuilderTextField(
                                                  name: 'email',
                                                  initialValue:
                                                      userResult!.email!,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return "Must input email";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration:
                                                      customInputDecoration()),
                                            )
                                          : Text(
                                              userResult!.email!,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF444444)),
                                            )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.cake,
                                        color: Color(0xFF8C981A),
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10.0),
                                      editing
                                          ? Expanded(
                                              child: FormBuilderDateTimePicker(
                                                name: 'birthDate',
                                                format:
                                                    DateFormat('dd/MM/yyyy'),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return "Must pick a date";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration:
                                                    customInputDecoration(),
                                                initialValue:
                                                    userResult!.birthDate!,
                                              ),
                                            )
                                          : Text(
                                              formatDate(userResult!.birthDate!,
                                                  [d, '.', m, '.', yyyy]),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF444444)),
                                            )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.diamond_outlined,
                                        color: Color(0xFF8C981A),
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10.0),
                                      Text(
                                        userResult!.subscription == null
                                            ? "You have a regular account"
                                            : "You have a premium account",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF444444)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.03),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              customContainer(TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Chats()));
                                },
                                icon: const Icon(
                                  Icons.chat_bubble,
                                  color: Color(0xFF394949),
                                ),
                                label: const Text("Chats",
                                    style: TextStyle(color: Colors.black)),
                              )),
                              customContainer(
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const QnaPage()));
                                        },
                                        icon: const Icon(Icons.question_answer,
                                            color: Color(0xFF394949)),
                                        label: const Text(
                                          "QnA",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              customContainer(TextButton.icon(
                                onPressed: userResult!.subscription == null ||
                                        userResult!
                                            .subscription!.expirationDate!
                                            .isBefore(DateTime.now())
                                    ? () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const SubscriptionPage()))
                                            .then((value) => fetchData());
                                      }
                                    : null,
                                icon: const Icon(
                                  Icons.diamond_outlined,
                                  color: Color(0xFF394949),
                                ),
                                label: const Text("Premium",
                                    style: TextStyle(color: Colors.black)),
                              )),
                              customContainer(
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title:
                                                        const Text("Log out"),
                                                    content: const Text(
                                                        "Are you sure you want to log out from the app?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: (() {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                        child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black)),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            try {
                                                              Authentification
                                                                  .token = '';

                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              const LoginPage()),
                                                                  (route) =>
                                                                      false);
                                                            } catch (e) {
                                                              alertBoxMoveBack(
                                                                  context,
                                                                  "Error",
                                                                  e.toString());
                                                            }
                                                          },
                                                          child: const Text(
                                                              "Confirm",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red)))
                                                    ],
                                                  ));
                                        },
                                        icon: const Icon(Icons.logout,
                                            color: Color(0xFF394949)),
                                        label: const Text(
                                          "Log out",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

Container customContainer(Widget child) {
  return Container(
    margin: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
    padding: const EdgeInsets.all(15),
    width: 160,
    decoration: BoxDecoration(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: child,
  );
}
