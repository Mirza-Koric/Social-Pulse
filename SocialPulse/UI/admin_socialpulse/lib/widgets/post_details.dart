import 'package:admin_socialpulse/models/group.dart';
import 'package:admin_socialpulse/models/post.dart';
import 'package:admin_socialpulse/models/tag.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/post_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PostDetails extends StatefulWidget {
  final Post? post;
  final List<Group> groups;
  final List<Tag> tags;
  final List<User> users;

  const PostDetails(
      {this.post,
      required this.groups,
      required this.tags,
      required this.users,
      super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PostProvider _postProvider = PostProvider();

  List<DropdownMenuItem<int>> groupMenuItemList = [];
  List<DropdownMenuItem<int>> tagMenuItemList = [];
  List<DropdownMenuItem<int>> userMenuItemList = [];

  @override
  void initState() {
    super.initState();
    _postProvider = context.read<PostProvider>();

    groupMenuItemList = widget.groups
        .map((e) => DropdownMenuItem<int>(value: e.id, child: Text(e.name!)))
        .toList();

    tagMenuItemList = widget.tags
        .map((e) => DropdownMenuItem<int>(value: e.id, child: Text(e.name!)))
        .toList();
    tagMenuItemList.insert(
        0, const DropdownMenuItem<int>(value: 0, child: Text("--")));

    userMenuItemList = widget.users
        .map(
            (e) => DropdownMenuItem<int>(value: e.id, child: Text(e.username!)))
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
            const Text("Post details", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Title"),
              name: "title",
              initialValue: widget.post == null ? "" : widget.post!.title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input title";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              decoration: customInputDecoration(hint: "Text"),
              maxLines: 4,
              name: "text",
              initialValue: widget.post == null ? "" : widget.post!.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Must input text";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10),
            FormBuilderDropdown<bool>(
                decoration: customInputDecoration(hint: "isAdvert"),
                name: "isAdvert",
                items: const [
                  DropdownMenuItem(value: false, child: Text("is not Advert")),
                  DropdownMenuItem(value: true, child: Text("is Advert"))
                ],
                initialValue:
                    widget.post == null ? false : widget.post!.isAdvert),
            const SizedBox(height: 10),
            FormBuilderDropdown<int>(
                name: "userId",
                items: userMenuItemList,
                decoration: customInputDecoration(),
                initialValue: widget.post == null ? 1 : widget.post!.userId),
            const SizedBox(height: 10),
            FormBuilderDropdown<int>(
                name: "groupId",
                items: groupMenuItemList,
                decoration: customInputDecoration(),
                initialValue: widget.post == null ? 1 : widget.post!.groupId),
            const SizedBox(height: 10),
            FormBuilderDropdown<int>(
                name: "tagId",
                items: tagMenuItemList,
                decoration: customInputDecoration(),
                initialValue: widget.post == null || widget.post!.tagId == null
                    ? 0
                    : widget.post!.tagId),
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

                        request['id'] =
                            widget.post != null ? widget.post!.id : 0;

                        request['tagId'] =
                            _formKey.currentState?.value['tagId'] == 0
                                ? null
                                : _formKey.currentState?.value['tagId'];

                        if (widget.post == null) {
                          await _postProvider.insert(request);
                        } else if (widget.post != null) {
                          await _postProvider.update(request);
                        }

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Successfully added/updated post")));
                          Navigator.pop(context, 'refresh');
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
