import 'package:admin_socialpulse/models/notification.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/providers/notification_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:admin_socialpulse/widgets/notification_details.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class NotificationsViewPage extends StatefulWidget {
  const NotificationsViewPage({super.key});

  @override
  State<NotificationsViewPage> createState() => _NotificationsViewPageState();
}

class _NotificationsViewPageState extends State<NotificationsViewPage> {
  late NotificationProvider _notificationProvider = NotificationProvider();
  SearchResult<Notif>? notificationResult;

  bool isLoading = true;

  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notificationProvider = context.read<NotificationProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var data = await _notificationProvider.getPaged(
          filter: {"userId": int.parse(Authentification.tokenDecoded!["Id"])});

      if (mounted) {
        setState(() {
          notificationResult = data;
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
              notificationResult != null &&
              notificationResult!.pageCount > 1
          ? const SizedBox(
              height: 20,
            )
          : Container(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (isLoading == false &&
            notificationResult != null &&
            notificationResult!.pageCount > 1)
          for (int i = 0; i < notificationResult!.pageCount; i++)
            InkWell(
                onTap: () async {
                  try {
                    var data = await _notificationProvider.getPaged(filter: {
                      'title': _titleController.text,
                      'userId': int.parse(Authentification.tokenDecoded!["Id"]),
                      'pageNumber': i + 1
                    });

                    if (mounted) {
                      setState(() {
                        notificationResult = data;
                      });
                    }
                  } on Exception catch (e) {
                    if (mounted) {
                      alertBox(context, "Error", e.toString());
                    }
                  }
                },
                child: CircleAvatar(
                    backgroundColor: (i + 1 == notificationResult?.pageNumber)
                        ? Colors.lightGreen
                        : Colors.white,
                    child: Text(
                      (i + 1).toString(),
                      style: TextStyle(
                          color: (i + 1 == notificationResult?.pageNumber)
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
              DataColumn(label: Text("Title")),
              DataColumn(label: Text("Content")),
              DataColumn(label: Text("Timestamp")),
            ],
            rows: notificationResult?.items
                    .map((Notif n) => DataRow(
                            onSelectChanged: (value) async {
                              var wait = await showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        children: [
                                          NotificationDetails(
                                            notification: n,
                                          )
                                        ],
                                      ));
                              if (wait == 'refresh') {
                                fetchData();
                              }
                            },
                            cells: [
                              DataCell(Text(n.title ?? "")),
                              DataCell(Text(n.content ?? "")),
                              DataCell(Text(n.createdAt != null
                                  ? formatDate(n.createdAt!,
                                      [dd, '.', mm, '.', yyyy, ' ', HH])
                                  : " ")),
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
              controller: _titleController,
              decoration: const InputDecoration(label: Text("Title")),
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
                  var data = await _notificationProvider.getPaged(filter: {
                    'title': _titleController.text,
                    'userId': int.parse(Authentification.tokenDecoded!["Id"]),
                  });

                  if (mounted) {
                    setState(() {
                      notificationResult = data;
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
                        const SimpleDialog(children: [NotificationDetails()]));
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
