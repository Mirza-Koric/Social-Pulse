import 'package:admin_socialpulse/models/question.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/question_provicer.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/question_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class QnAPage extends StatefulWidget {
  const QnAPage({super.key});

  @override
  State<QnAPage> createState() => _QnAPageState();
}

class _QnAPageState extends State<QnAPage> {
  QuestionProvider _questionProvider = QuestionProvider();
  SearchResult<Question>? questionResult;

  bool isLoading = true;

  final TextEditingController _textController = TextEditingController();
  int _dropdownValue = 2;
  int _dropdownValue2 = 0;

  late UserProvider _userProvider = UserProvider();
  SearchResult<User>? userResult;
  List<DropdownMenuItem> userMenuItemList = [];

  @override
  void initState() {
    super.initState();
    _questionProvider = context.read<QuestionProvider>();
    _userProvider = context.read<UserProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _questionProvider.getPaged();

      userResult = await _userProvider.getPaged(filter: {"pageSize": 1000});

      if (mounted) {
        setState(() {
          questionResult = data;
          isLoading = false;
        });
        userMenuItemList = userResult!.items
            .map((e) =>
                DropdownMenuItem<int>(value: e.id, child: Text(e.username!)))
            .toList();
        userMenuItemList.insert(
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
      isLoading == false &&
              questionResult != null &&
              questionResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false &&
            questionResult != null &&
            questionResult!.pageCount > 1)
          for (int i = 0; i < questionResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _questionProvider.getPaged(filter: {
                      'text': _textController.text,
                      'answered': _dropdownValue == 2
                          ? null
                          : _dropdownValue == 0
                              ? false
                              : true,
                      'userId': _dropdownValue2 == 0 ? null : _dropdownValue2,
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        questionResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == questionResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == questionResult?.pageNumber)
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
          width: 1000,
          child: DataTable(
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text("Text")),
              DataColumn(label: Text("User")),
              DataColumn(label: Text("Answer")),
            ],
            rows: questionResult?.items
                    .map((Question q) => DataRow(
                            onSelectChanged: (value) async {
                              var wait = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [
                                          QuestionDetails(
                                            question: q,
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
                                      const BoxConstraints(maxWidth: 200),
                                  child: Text(q.text ?? ""))),
                              DataCell(Text(
                                  q.user == null ? "" : q.user!.username!)),
                              DataCell(Text(q.answer == null
                                  ? "Not answered"
                                  : q.answer!.text!)),
                            ]))
                    .toList() ??
                [],
            // source: _DataSource(
            //     data: questionList, context: context, callback: fetchData),
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
          Expanded(
              child: DropdownButtonHideUnderline(
            child: DropdownButton(
                items: const [
                  DropdownMenuItem(value: 2, child: Text("--")),
                  DropdownMenuItem(value: 0, child: Text("Not Answered")),
                  DropdownMenuItem(value: 1, child: Text("Answered")),
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
                items: userMenuItemList,
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
                  var data = await _questionProvider.getPaged(filter: {
                    'text': _textController.text,
                    'answered': _dropdownValue == 2
                        ? null
                        : _dropdownValue == 0
                            ? false
                            : true,
                    'userId': _dropdownValue2 == 0 ? null : _dropdownValue2,
                  });

                  if (mounted) {
                    setState(() {
                      questionResult = data;
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
        ],
      ),
    );
  }
}
