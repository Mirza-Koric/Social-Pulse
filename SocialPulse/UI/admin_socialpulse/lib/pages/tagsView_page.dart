import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/tag.dart';
import 'package:admin_socialpulse/providers/tag_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/tag_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TagsViewPage extends StatefulWidget {
  const TagsViewPage({super.key});

  @override
  State<TagsViewPage> createState() => _TagsViewPageState();
}

class _TagsViewPageState extends State<TagsViewPage> {
  late TagProvider _tagProvider = TagProvider();
  SearchResult<Tag>? tagResult;

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tagProvider = context.read<TagProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _tagProvider.getPaged();

      if (mounted) {
        setState(() {
          tagResult = data;
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        alertBox(context, "Error", e.toString());
      }
    }
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTopBar(),
      isLoading
          ? const SpinKitFadingCircle(color: Colors.lightGreen)
          : _buildDataTable(),
      isLoading == false && tagResult != null && tagResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false && tagResult != null && tagResult!.pageCount > 1)
          for (int i = 0; i < tagResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _tagProvider.getPaged(filter: {
                      'name': _nameController.text,
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        tagResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == tagResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == tagResult?.pageNumber)
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
            ],
            rows: tagResult?.items
                    .map((Tag t) => DataRow(
                            onSelectChanged: (value) async {
                              var wait = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [
                                          TagDetails(
                                            tag: t,
                                          )
                                        ],
                                      ));
                              if (wait == 'refresh') {
                                fetchData();
                              }
                            },
                            cells: [
                              DataCell(Text(t.name ?? "")),
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
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              onPressed: () async {
                try {
                  var data = await _tagProvider.getPaged(filter: {
                    'name': _nameController.text,
                  });

                  if (mounted) {
                    setState(() {
                      tagResult = data;
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
                        const SimpleDialog(children: [TagDetails()]));
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
