import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/user_details.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UsersViewPage extends StatefulWidget {
  const UsersViewPage({super.key});

  @override
  State<UsersViewPage> createState() => _UsersViewPageState();
}

class _UsersViewPageState extends State<UsersViewPage> {
  late UserProvider _userProvider = UserProvider();
  SearchResult<User>? userResult;

  bool isLoading = true;
  int _dropdownValue = 2;
  int _dropdownValue2 = 0;

  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _userProvider.getPaged();

      if (mounted) {
        setState(() {
          userResult = data;
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        alertBox(context, "Error", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTopBar(),
      isLoading
          ? const SpinKitFadingCircle(color: Colors.lightGreen)
          : _buildDataTable(),
      isLoading == false && userResult != null && userResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false &&
            userResult != null &&
            userResult!.pageCount > 1)
          for (int i = 0; i < userResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _userProvider.getPaged(filter: {
                      "username": _usernameController.text,
                      'role': _dropdownValue2 == 0
                          ? null
                          : _dropdownValue2 == 1
                              ? "Administrator"
                              : "User",
                      'subscribed': _dropdownValue == 2
                          ? null
                          : _dropdownValue == 0
                              ? false
                              : true,
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        userResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == userResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == userResult?.pageNumber)
                              ? Colors.white
                              : Colors.lightGreen),
                    ))),
      ]),
      const SizedBox(
        height: 20,
      )
    ]);
  }

  Expanded _buildDataTable() {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 800,
          child: DataTable(
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text("Username")),
              DataColumn(label: Text("Email")),
              DataColumn(label: Text("Birthday")),
              DataColumn(label: Text("Role")),
              DataColumn(label: Text("")),
            ],
            rows: userResult?.items
                    .map((User u) => DataRow(
                            onSelectChanged: (value) async {
                              var wait = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [UserDetails(user: u)],
                                      ));
                              if (wait == 'refresh') {
                                fetchData();
                              }
                            },
                            cells: [
                              DataCell(Text(u.username ?? "")),
                              DataCell(Text(u.email ?? "")),
                              DataCell(Text(u.birthDate != null
                                  ? formatDate(
                                      u.birthDate!, [dd, '.', mm, '.', yyyy])
                                  : "")),
                              DataCell(Text(u.role ?? "")),
                              const DataCell(Icon(Icons.more_vert))
                            ]))
                    .toList() ??
                [],
          ),
        ),
      ),
    );
  }

  Padding _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 50, 30),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(label: Text("Username")),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: DropdownButtonHideUnderline(
            child: DropdownButton(
                items: const [
                  DropdownMenuItem(
                      value: 2,
                      child: Text(
                        "(Subscribed)",
                        style: TextStyle(color: Colors.grey),
                      )),
                  DropdownMenuItem(value: 0, child: Text("Not Subscribed")),
                  DropdownMenuItem(value: 1, child: Text("Subscribed")),
                ],
                focusColor: Colors.transparent,
                value: _dropdownValue,
                onChanged: ((value) {
                  if (value is int) {
                    if (mounted) {
                      setState(() {
                        _dropdownValue = value;
                      });
                    }
                  }
                })),
          )),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: DropdownButtonHideUnderline(
            child: DropdownButton(
                items: const [
                  DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "(Role)",
                        style: TextStyle(color: Colors.grey),
                      )),
                  DropdownMenuItem(value: 1, child: Text("Administrator")),
                  DropdownMenuItem(value: 2, child: Text("User")),
                ],
                focusColor: Colors.transparent,
                value: _dropdownValue2,
                onChanged: ((value) {
                  if (value is int) {
                    if (mounted) {
                      setState(() {
                        _dropdownValue2 = value;
                      });
                    }
                  }
                })),
          )),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              onPressed: () async {
                try {
                  var data = await _userProvider.getPaged(filter: {
                    'username': _usernameController.text,
                    'role': _dropdownValue2 == 0
                        ? null
                        : _dropdownValue2 == 1
                            ? "Administrator"
                            : "User",
                    'subscribed': _dropdownValue == 2
                        ? null
                        : _dropdownValue == 0
                            ? false
                            : true
                  });

                  if (mounted) {
                    setState(() {
                      userResult = data;
                    });
                  }
                } on Exception catch (e) {
                  if (mounted) {
                    alertBox(context, "Error", e.toString());
                  }
                }
              },
              child:
                  const Text("Search", style: TextStyle(color: Colors.black))),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              onPressed: () async {
                var wait = await showDialog(
                    context: context,
                    builder: (context) =>
                        const SimpleDialog(children: [UserDetails()]));
                if (wait == 'refresh') {
                  fetchData();
                }
              },
              child: const Text("Add", style: TextStyle(color: Colors.black))),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
