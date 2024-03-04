// import 'package:admin_socialpulse/models/search_result.dart';
// import 'package:admin_socialpulse/providers/user_provider.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';

// import '../models/user.dart';

// class UsersPage extends StatefulWidget {
//   const UsersPage({Key? key, this.roleUser}) : super(key: key);
//   final String? roleUser;

//   @override
//   State<UsersPage> createState() => _UsersPageState();
// }

// class _UsersPageState extends State<UsersPage> {
//   late UserProvider _userProvider = UserProvider();
//   SearchResult<User>? result;
//   bool isLoading = true;
//   int _dropdownValue = 2;

//   final TextEditingController _nameController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     _userProvider = context.read<UserProvider>();

//     initTable();
//   }

//   Future<void> initTable() async {
//     try {
//       var data = await _userProvider.getPaged();

//       if (mounted) {
//         setState(() {
//           result = data;
//           isLoading = false;
//         });
//       }
//     } on Exception catch (e) {
//       //alertBox(context, AppLocalizations.of(context).error, e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       _buildSearch(),
//       isLoading ? const SpinKitRing(color: Colors.brown) : _buildDataTable(),
//       isLoading == false && result != null && result!.pageCount > 1
//           ? const SizedBox(
//               height: 20,
//             )
//           : Container(),
//       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//         if (isLoading == false && result != null && result!.pageCount > 1)
//           for (int i = 0; i < result!.pageCount; i++)
//             InkWell(
//                 onTap: () async {
//                   try {
//                     var data = await _userProvider.getPaged(filter: {
//                       "fullName": _nameController.text,
//                       'roleName':
//                           widget.roleUser != null ? '${widget.roleUser}' : '',
//                       'isActive': _dropdownValue == 1 ? true : false,
//                       'pageNumber': i + 1
//                     });

//                     if (mounted) {
//                       setState(() {
//                         result = data;
//                       });
//                     }
//                   } on Exception catch (e) {
//                     // alertBox(context, AppLocalizations.of(context).error,
//                     //     e.toString());
//                   }
//                 },
//                 child: CircleAvatar(
//                     backgroundColor: (i + 1 == result?.pageNumber)
//                         ? Colors.brown
//                         : Colors.white,
//                     child: Text(
//                       (i + 1).toString(),
//                       style: TextStyle(
//                           color: (i + 1 == result?.pageNumber)
//                               ? Colors.white
//                               : Colors.brown),
//                     ))),
//       ]),
//       const SizedBox(
//         height: 20,
//       )
//     ]);
//   }

//   Expanded _buildDataTable() {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: DataTable(
//           showCheckboxColumn: false,
//           columns: const [
//             DataColumn(label: Text("username")),
//             DataColumn(label: Text("email")),
//             DataColumn(label: Text("bDay")),
//             DataColumn(label: Text("role")),
//           ],
//           rows: result?.items
//                   .map((User u) => DataRow(
//                           // onSelectChanged: (value) async {
//                           //   var refresh = await Navigator.of(context)
//                           //       .push(MaterialPageRoute(
//                           //     builder: (context) => UserDetailPage(
//                           //       user: e,
//                           //       roleUser: widget.roleUser,
//                           //     ),
//                           //   ));

//                           //   if (refresh == 'reload') {
//                           //     initTable();
//                           //   }
//                           // },
//                           onSelectChanged: (value) {},
//                           cells: [
//                             DataCell(Text(u.username ?? "")),
//                             DataCell(Text(u.email ?? "")),
//                             DataCell(Text(u.birthDate != null
//                                 ? formatDate(
//                                     u.birthDate!, [dd, '.', mm, '.', yyyy])
//                                 : "")),
//                             DataCell(Text(u.role ?? "")),
//                           ]))
//                   .toList() ??
//               [],
//         ),
//       ),
//     );
//   }

//   Padding _buildSearch() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(30, 20, 50, 50),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(label: Text("Username")),
//             ),
//           ),
//           const SizedBox(
//             width: 15,
//           ),
//           Expanded(
//               child: DropdownButton(
//                   items: const [
//                 DropdownMenuItem(value: 2, child: Text("--")),
//                 DropdownMenuItem(value: 0, child: Text("Unsubscribed")),
//                 DropdownMenuItem(value: 1, child: Text("Subscribed")),
//               ],
//                   value: _dropdownValue,
//                   onChanged: ((value) {
//                     if (value is int) {
//                       if (mounted) {
//                         setState(() {
//                           _dropdownValue = value;
//                         });
//                       }
//                     }
//                   }))),
//           const SizedBox(
//             width: 20,
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 try {
//                   var data = await _userProvider.getPaged(filter: {
//                     'roleName':
//                         widget.roleUser != null ? '${widget.roleUser}' : '',
//                     "fullName": _nameController.text,
//                     'isActive': _dropdownValue == 1 ? true : false
//                   });

//                   if (mounted) {
//                     setState(() {
//                       result = data;
//                     });
//                   }
//                 } on Exception catch (e) {
//                   // alertBox(context, AppLocalizations.of(context).error,
//                   //     e.toString());
//                 }
//               },
//               child: const Text("Search")),
//           const SizedBox(
//             width: 15,
//           ),
//           ElevatedButton(
//               onPressed: null,
//               // onPressed: () async {
//               //   var refresh = await Navigator.of(context).push(
//               //     MaterialPageRoute(
//               //       builder: (context) => UserDetailPage(
//               //         user: null,
//               //         roleUser: widget.roleUser,
//               //       ),
//               //     ),
//               //   );
//               //   if (refresh == 'reload') {
//               //     initTable();
//               //   }
//               // },
//               child: Text("Add")),
//           const SizedBox(
//             width: 15,
//           ),
//         ],
//       ),
//     );
//   }
// }
