import 'package:admin_socialpulse/models/notification.dart';
import 'package:admin_socialpulse/providers/notification_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class NotificationDetails extends StatefulWidget {
  final Notif? notification;
  const NotificationDetails({this.notification, super.key});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  final _formKey = GlobalKey<FormBuilderState>();

  late NotificationProvider _notificationProvider = NotificationProvider();
  @override
  void initState() {
    super.initState();
    _notificationProvider = context.read<NotificationProvider>();
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
            const Text("Notification details", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Title"),
              name: "title",
              initialValue:
                  widget.notification == null ? "" : widget.notification!.title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input Title";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Content"),
              name: "content",
              initialValue: widget.notification == null
                  ? ""
                  : widget.notification!.content,
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

                        request['id'] = widget.notification != null
                            ? widget.notification!.id
                            : 0;

                        if (widget.notification == null) {
                          await _notificationProvider.insert(request);
                        } else if (widget.notification != null) {
                          await _notificationProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Successfully added/updated notification")));
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
