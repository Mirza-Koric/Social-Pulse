import 'package:admin_socialpulse/models/group.dart';
import 'package:admin_socialpulse/providers/group_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class GroupDetails extends StatefulWidget {
  final Group? group;
  const GroupDetails({this.group, super.key});

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  final _formKey = GlobalKey<FormBuilderState>();

  late GroupProvider _groupProvider = GroupProvider();

  @override
  void initState() {
    super.initState();
    _groupProvider = context.read<GroupProvider>();
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
                    widget.group == null ? "0" : widget.group!.id.toString(),
                enabled: false),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Name"),
              name: "name",
              initialValue: widget.group == null ? "" : widget.group!.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input name";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Description"),
              name: "description",
              initialValue:
                  widget.group == null ? "" : widget.group!.description,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input description";
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

                        if (widget.group == null) {
                          await _groupProvider.insert(request);
                        } else if (widget.group != null) {
                          await _groupProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Successfully added/updated group")));
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
