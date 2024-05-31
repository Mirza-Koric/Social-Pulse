import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/providers/post_provider.dart';
import 'package:mobile_socialpulse/providers/tag_provider.dart';
import 'package:provider/provider.dart';

import '../models/group.dart';
import '../models/search_result.dart';
import '../models/tag.dart';
import '../providers/group_provider.dart';
import '../utils/utils.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late GroupProvider _groupProvider = GroupProvider();
  SearchResult<Group>? groupResult;
  late TagProvider _tagProvider = TagProvider();
  SearchResult<Tag>? tagResult;
  late PostProvider _postProvider = PostProvider();

  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = true;
  List<String>? images;

  @override
  void initState() {
    super.initState();

    _groupProvider = context.read<GroupProvider>();
    _tagProvider = context.read<TagProvider>();
    _postProvider = context.read<PostProvider>();

    initForm();
  }

  Future<void> initForm() async {
    try {
      groupResult = await _groupProvider.getPaged();
      tagResult = await _tagProvider.getPaged();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
  }

  List<File>? _images; //dart.io
  List<String>? _base64Images;

  Future getImage() async {
    try {
      var result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.image);
      if (result != null) {
        _images = result.paths.map((path) => File(path!)).toList();
        _base64Images =
            _images!.map((f) => base64Encode(f.readAsBytesSync())).toList();

        setState(() {
          images = _base64Images;
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
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Create New Post",
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FormBuilderTextField(
                    name: "title",
                    style: const TextStyle(fontSize: 25),
                    minLines: 1,
                    maxLines: 3,
                    validator: (value) {
                        if (value !=null && value.isNotEmpty) {
                          if (value.length <= 30) {
                            return null;
                          } else {
                            return "Title can't be longer than 30 chars";
                          }
                        }
                      return "Title is required";
                    },
                    decoration: customInputDecoration(hint: "Title"),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormBuilderDropdown<String>(
                      name: "groupId",
                      validator: (value) =>
                      value == null ? 'Please select group' : null,
                      decoration: customInputDecoration(hint: "Group"),
                      items: groupResult?.items
                          .map((g) =>
                          DropdownMenuItem(
                              alignment:
                              AlignmentDirectional.centerStart,
                              value: g.id.toString(),
                              child: Text(g.name ?? "")))
                          .toList() ??
                          []),
                  const SizedBox(
                    height: 25,
                  ),
                  FormBuilderDropdown<String>(
                      name: "tagId",
                      decoration:
                      customInputDecoration(hint: "Tag (optional)"),
                      items: tagResult?.items
                          .map((g) =>
                          DropdownMenuItem(
                              alignment:
                              AlignmentDirectional.centerStart,
                              value: g.id.toString(),
                              child: Text(g.name ?? "")))
                          .toList() ??
                          []),
                  const SizedBox(
                    height: 25,
                  ),
                  FormBuilderTextField(
                    name: "text",
                    style: const TextStyle(fontSize: 20),
                    maxLines: 4,
                    autofocus: false,
                    validator: (value) {
                      if (value == null) {
                        return "Please input post text";
                      }
                      else if (value.isEmpty) {
                        return "Please input post text";
                      }
                      else if (value.isNotEmpty && value.length > 500) {
                        return "Can't be longer than 500 chars";
                      } else {
                        return null;
                      }
                    },
                    decoration: customInputDecoration(hint: "Post text"),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  images == null || images == [] ?
                  TextButton(
                      onPressed: getImage,
                      child: const Text(
                        "Choose image",
                        style: TextStyle(color: Colors.black),
                      )):
                      TextButton(
                          onPressed: (){
                            setState(() {
                              images=null;
                              _images=null;
                              _base64Images=null;
                            });
                          },
                          child: const Text(
                        "Remove selection",
                        style: TextStyle(color: Colors.black),
                      )),
                  images == null || images == []
                      ? Container()
                      : Container(
                          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 350),
                          child: ListView.builder(
                            itemCount: images!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return imageFromBase64String(images![index]);
                              }
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                    onPressed:
                        () async {
                      try {
                        _formKey.currentState?.save();

                        if (!(_formKey.currentState == null)) {
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> request =
                            Map.of(_formKey.currentState!.value);

                            request['userId'] = int.parse(
                                Authentification.tokenDecoded?["Id"]);

                            dynamic postImages;

                            if(images != null && images!.isEmpty==false) {
                              postImages=[];

                              for (var image in images!) {
                                postImages.add({"data": image, "contentType":"image"});
                              }

                              request['images']=postImages;
                            }

                            await _postProvider.insert(request);

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Successfully created post")));

                              _formKey.currentState?.reset();
                              _formKey.currentState!.fields['groupId']?.reset();
                              _formKey.currentState!.fields['tagId']?.reset();

                              setState(() {
                                images=null;
                                _images=null;
                                _base64Images=null;
                              });
                            }
                          }
                        }
                        else {
                          alertBox(context, "Error", "Please input fields");
                        }
                      } catch (e) {
                        if (mounted) {
                          alertBox(context, "Error", e.toString());
                        }
                      }
                    },

                    child: const Text("Submit",
                        style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
