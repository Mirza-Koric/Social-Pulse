import 'package:admin_socialpulse/models/comment.dart';
import 'package:admin_socialpulse/models/post.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/comment_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CommentDetails extends StatefulWidget {
  final Comment? comment;
  final List<User> users;
  final List<Post> posts;

  const CommentDetails(
      {this.comment, required this.users, required this.posts, super.key});

  @override
  State<CommentDetails> createState() => _CommentDetailsState();
}

class _CommentDetailsState extends State<CommentDetails> {
  final _formKey = GlobalKey<FormBuilderState>();

  late CommentProvider _commentProvider = CommentProvider();

  List<DropdownMenuItem<int>> postMenuItemList = [];
  List<DropdownMenuItem<int>> userMenuItemList = [];

  @override
  void initState() {
    super.initState();
    _commentProvider = context.read<CommentProvider>();

    userMenuItemList = widget.users
        .map(
            (e) => DropdownMenuItem<int>(value: e.id, child: Text(e.username!)))
        .toList();
    postMenuItemList = widget.posts
        .map((e) => DropdownMenuItem<int>(value: e.id, child: Text(e.title!)))
        .toList();
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
            const Text("Comment details", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            FormBuilderTextField(
                name: "id",
                initialValue: widget.comment == null
                    ? "0"
                    : widget.comment!.id.toString(),
                enabled: false),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Text"),
              name: "text",
              maxLines: 2,
              initialValue: widget.comment == null ? "" : widget.comment!.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input text";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            FormBuilderDropdown<int>(
                decoration: customInputDecoration(),
                name: "postId",
                items: postMenuItemList,
                initialValue:
                    widget.comment == null ? 1 : widget.comment!.postId!),
            const SizedBox(height: 10),
            FormBuilderDropdown<int>(
                decoration: customInputDecoration(),
                name: "userId",
                items: userMenuItemList,
                initialValue:
                    widget.comment == null ? 1 : widget.comment!.userId),
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

                        if (widget.comment == null) {
                          await _commentProvider.insert(request);
                        } else if (widget.comment != null) {
                          await _commentProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Successfully added/updated comment")));
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
