import 'package:admin_socialpulse/models/group.dart';
import 'package:admin_socialpulse/models/post.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/tag.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/group_provider.dart';
import 'package:admin_socialpulse/providers/post_provider.dart';
import 'package:admin_socialpulse/providers/tag_provider.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:admin_socialpulse/providers/recommend_result_provider.dart';

class PostsViewPage extends StatefulWidget {
  const PostsViewPage({super.key});

  @override
  State<PostsViewPage> createState() => _PostsViewPageState();
}

class _PostsViewPageState extends State<PostsViewPage> {
  late PostProvider _postProvider = PostProvider();
  SearchResult<Post>? postResult;

  late RecommendResultProvider _recommendResultProvider =
      RecommendResultProvider();

  late UserProvider _userProvider = UserProvider();
  SearchResult<User>? userResult;

  late GroupProvider _groupProvider = GroupProvider();
  SearchResult<Group>? groupResult;
  List<DropdownMenuItem> groupMenuItemList = [];

  late TagProvider _tagProvider = TagProvider();
  SearchResult<Tag>? tagResult;
  List<DropdownMenuItem> tagMenuItemList = [];

  bool isLoading = true;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  int _dropdownValue = 2;
  int _dropdownValue2 = 0;
  int _dropdownValue3 = 0;

  @override
  void initState() {
    super.initState();
    _postProvider = context.read<PostProvider>();
    _userProvider = context.read<UserProvider>();
    _groupProvider = context.read<GroupProvider>();
    _tagProvider = context.read<TagProvider>();
    _recommendResultProvider = context.read<RecommendResultProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _postProvider.getPaged();

      groupResult = await _groupProvider.getPaged(filter: {"pageSize": 1000});
      tagResult = await _tagProvider.getPaged(filter: {"pageSize": 1000});
      userResult = await _userProvider.getPaged(filter: {"pageSize": 1000});

      if (mounted) {
        setState(() {
          postResult = data;
          isLoading = false;
        });
        groupMenuItemList = groupResult!.items
            .map(
                (e) => DropdownMenuItem<int>(value: e.id, child: Text(e.name!)))
            .toList();
        groupMenuItemList.insert(
            0, const DropdownMenuItem<int>(value: 0, child: Text("--")));

        tagMenuItemList = tagResult!.items
            .map(
                (e) => DropdownMenuItem<int>(value: e.id, child: Text(e.name!)))
            .toList();
        tagMenuItemList.insert(
            0, const DropdownMenuItem<int>(value: 0, child: Text("--")));
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
      isLoading == false && postResult != null && postResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false &&
            postResult != null &&
            postResult!.pageCount > 1)
          for (int i = 0; i < postResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _postProvider.getPaged(filter: {
                      'title': _titleController.text,
                      'text': _textController.text,
                      'isAdvert': _dropdownValue == 2
                          ? null
                          : _dropdownValue == 0
                              ? false
                              : true,
                      'groupId': _dropdownValue2 == 0 ? null : _dropdownValue2,
                      'tagId': _dropdownValue3 == 0 ? null : _dropdownValue3,
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        postResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == postResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == postResult?.pageNumber)
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
          width: 1100,
          child: DataTable(
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text("Title")),
              DataColumn(label: Text("Text")),
              DataColumn(label: Text("Advert")),
              DataColumn(label: Text("User")),
              DataColumn(label: Text("Group")),
              DataColumn(label: Text("Tag")),
              DataColumn(label: Text("Likes")),
              DataColumn(label: Text("Dislikes")),
            ],
            rows: postResult?.items
                    .map((Post p) => DataRow(
                            onSelectChanged: (value) async {
                              var refresh = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [
                                          PostDetails(
                                            post: p,
                                            groups: groupResult!.items,
                                            tags: tagResult!.items,
                                            users: userResult!.items,
                                          )
                                        ],
                                      ));
                              if (refresh == 'reload') {
                                fetchData();
                              }
                            },
                            cells: [
                              DataCell(ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 100),
                                  child: Text(p.title ?? ""))),
                              DataCell(ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 150),
                                  child: Text(p.text ?? ""))),
                              DataCell(Text(p.isAdvert.toString())),
                              DataCell(Text(
                                  p.user == null ? "" : p.user!.username!)),
                              DataCell(
                                  Text(p.group == null ? "" : p.group!.name!)),
                              DataCell(Text(p.tag == null ? "" : p.tag!.name!)),
                              DataCell(Text(p.likes == null
                                  ? ""
                                  : p.likes!
                                      .where((element) => element.type == true)
                                      .length
                                      .toString())),
                              DataCell(Text(p.likes == null
                                  ? ""
                                  : p.likes!
                                      .where((element) => element.type == false)
                                      .length
                                      .toString()))
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
      padding: const EdgeInsets.fromLTRB(30, 20, 50, 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(label: Text("Title")),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(label: Text("Text")),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    items: const [
                      DropdownMenuItem(value: 2, child: Text("--")),
                      DropdownMenuItem(value: 0, child: Text("Is not Advert")),
                      DropdownMenuItem(value: 1, child: Text("Is Advert")),
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
                    items: groupMenuItemList,
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
                width: 15,
              ),
              Expanded(
                  child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    items: tagMenuItemList,
                    focusColor: Colors.transparent,
                    value: _dropdownValue3,
                    onChanged: ((value) {
                      if (value is int) {
                        if (mounted) {
                          setState(() {
                            _dropdownValue3 = value;
                          });
                        }
                      }
                    })),
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                onPressed: () async {
                  try {
                    var data = await _postProvider.getPaged(filter: {
                      'title': _titleController.text,
                      'text': _textController.text,
                      'isAdvert': _dropdownValue == 2
                          ? null
                          : _dropdownValue == 0
                              ? false
                              : true,
                      'groupId': _dropdownValue2 == 0 ? null : _dropdownValue2,
                      'tagId': _dropdownValue3 == 0 ? null : _dropdownValue3
                    });

                    if (mounted) {
                      setState(() {
                        postResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: const Text("Search",
                    style: TextStyle(color: Colors.black))),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                onPressed: () async {
                  var wait = await showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(children: [
                            PostDetails(
                                groups: groupResult!.items,
                                tags: tagResult!.items,
                                users: userResult!.items)
                          ]));
                  if (wait == 'refresh') {
                    fetchData();
                  }
                },
                child:
                    const Text("Add", style: TextStyle(color: Colors.black))),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("Delete recommendations"),
                            content: const Text(
                                "Do you want to delete recommendations?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () async {
                                    try {
                                      await _recommendResultProvider
                                          .deleteData();
                                      if (mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Recommendations deleted")));
                                        Navigator.pop(context);
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        alertBoxMoveBack(
                                            context, "Error", e.toString());
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ));
                },
                child: const Text("Delete recommendations",
                    style: TextStyle(color: Colors.black))),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                onPressed: () async {
                  try {
                    await _recommendResultProvider.trainData();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Data trained")));
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error",
                          "Try deleting recommendations first\n${e.toString()}");
                    }
                  }
                },
                child: const Text("Train recommendations",
                    style: TextStyle(color: Colors.black)))
          ])
        ],
      ),
    );
  }
}
