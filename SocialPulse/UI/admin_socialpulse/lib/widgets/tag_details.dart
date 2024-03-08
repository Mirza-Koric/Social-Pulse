import 'package:admin_socialpulse/models/tag.dart';
import 'package:admin_socialpulse/providers/notification_provider.dart';
import 'package:admin_socialpulse/providers/tag_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TagDetails extends StatefulWidget {
  final Tag? tag;
  const TagDetails({this.tag, super.key});

  @override
  State<TagDetails> createState() => _TagDetailsState();
}

class _TagDetailsState extends State<TagDetails> {
  final _formKey = GlobalKey<FormBuilderState>();

  late TagProvider _tagProvider = TagProvider();
  late NotificationProvider _notificationProvider = NotificationProvider();

  @override
  void initState() {
    super.initState();
    _tagProvider = context.read<TagProvider>();
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
            const Text("User details", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            FormBuilderTextField(
                name: "id",
                initialValue:
                    widget.tag == null ? "0" : widget.tag!.id.toString(),
                enabled: false),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Name"),
              name: "name",
              initialValue: widget.tag == null ? "" : widget.tag!.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input name";
                } else {
                  return null;
                }
              },
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

                        if (widget.tag == null) {
                          var response = await _tagProvider.insert(request);

                          await _notificationProvider.sendRabbitNotification({
                            'title': "Added new tag",
                            'content':
                                "Successfully added new tag: ${response.name}",
                            'userId': 1
                          });
                        } else if (widget.tag != null) {
                          await _tagProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Successfully added/updated tag")));
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
