import 'package:admin_socialpulse/models/comment.dart';
import 'package:admin_socialpulse/models/post.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/comment_provider.dart';
import 'package:admin_socialpulse/providers/post_provider.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/comment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CommentsViewPage extends StatefulWidget {
  const CommentsViewPage({super.key});

  @override
  State<CommentsViewPage> createState() => _CommentsViewPageState();
}

class _CommentsViewPageState extends State<CommentsViewPage> {
  late CommentProvider _commentProvider = CommentProvider();
  SearchResult<Comment>? commentResult;

  late UserProvider _userProvider = UserProvider();
  SearchResult<User>? userResult;

  late PostProvider _postProvider = PostProvider();
  SearchResult<Post>? postResult;

  bool isLoading = true;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _commentProvider = context.read<CommentProvider>();
    _userProvider = context.read<UserProvider>();
    _postProvider = context.read<PostProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _commentProvider.getPaged();

      userResult = await _userProvider.getPaged(filter: {"pageSize": 1000});
      postResult = await _postProvider.getPaged(filter: {"pageSize": 1000});

      if (mounted) {
        setState(() {
          commentResult = data;
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
      isLoading == false &&
              commentResult != null &&
              commentResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false &&
            commentResult != null &&
            commentResult!.pageCount > 1)
          for (int i = 0; i < commentResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _commentProvider.getPaged(filter: {
                      'text': _textController.text,
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        commentResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == commentResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == commentResult?.pageNumber)
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
              DataColumn(label: Text("Text")),
              DataColumn(label: Text("Post")),
              DataColumn(label: Text("User")),
            ],
            rows: commentResult?.items
                    .map((Comment c) => DataRow(
                            onSelectChanged: (value) async {
                              var wait = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [
                                          CommentDetails(
                                            comment: c,
                                            users: userResult!.items,
                                            posts: postResult!.items,
                                          )
                                        ],
                                      ));
                              if (wait == 'refresh') {
                                fetchData();
                              }
                            },
                            cells: [
                              DataCell(ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 150),
                                  child: Text(c.text ?? ""))),
                              DataCell(
                                  Text(c.post == null ? "" : c.post!.title!)),
                              DataCell(Text(
                                  c.user == null ? "" : c.user!.username!)),
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
              controller: _textController,
              decoration: const InputDecoration(label: Text("Text")),
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
                  var data = await _commentProvider.getPaged(filter: {
                    'text': _textController.text,
                  });

                  if (mounted) {
                    setState(() {
                      commentResult = data;
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
                    builder: (context) => SimpleDialog(children: [
                          CommentDetails(
                              users: userResult!.items,
                              posts: postResult!.items)
                        ]));
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
