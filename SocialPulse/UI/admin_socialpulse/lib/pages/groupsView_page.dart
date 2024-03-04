import 'package:admin_socialpulse/models/group.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/providers/group_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/group_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class GroupsViewPage extends StatefulWidget {
  const GroupsViewPage({super.key});

  @override
  State<GroupsViewPage> createState() => _GroupsViewPageState();
}

class _GroupsViewPageState extends State<GroupsViewPage> {
  late GroupProvider _groupProvider = GroupProvider();
  SearchResult<Group>? groupResult;

  bool isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _groupProvider = context.read<GroupProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _groupProvider.getPaged();

      if (mounted) {
        setState(() {
          groupResult = data;
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
      isLoading == false && groupResult != null && groupResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false &&
            groupResult != null &&
            groupResult!.pageCount > 1)
          for (int i = 0; i < groupResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _groupProvider.getPaged(filter: {
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        groupResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == groupResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == groupResult?.pageNumber)
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
              DataColumn(label: Text("Name")),
              DataColumn(label: Text("Description")),
            ],
            rows: groupResult?.items
                    .map((Group g) => DataRow(
                            onSelectChanged: (value) async {
                              var wait = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [
                                          GroupDetails(
                                            group: g,
                                          )
                                        ],
                                      ));
                              if (wait == 'refresh') {
                                fetchData();
                              }
                            },
                            cells: [
                              DataCell(Text(g.name ?? "")),
                              DataCell(Text(g.description ?? "")),
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
              controller: _nameController,
              decoration: const InputDecoration(label: Text("Name")),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(label: Text("Description")),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              onPressed: () async {
                try {
                  var data = await _groupProvider.getPaged(filter: {
                    'name': _nameController.text,
                    'description': _descriptionController.text,
                  });

                  if (mounted) {
                    setState(() {
                      groupResult = data;
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
                        const SimpleDialog(children: [GroupDetails()]));
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
