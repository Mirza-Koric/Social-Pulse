import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/widgets/postWidget.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';
import '../providers/post_provider.dart';
import '../utils/utils.dart';

class PostsList extends StatefulWidget {

  final int? userId;
  final int? groupId;
  final String? username;
  final String? groupname;

  const PostsList({this.userId, this.username, this.groupId, this.groupname, super.key}): assert((userId==null) || (groupId==null));

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {

  late PostProvider _postProvider = PostProvider();
  SearchResult<Post>? postResult;
  List<Post>? fetchedPosts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _postProvider = context.read<PostProvider>();

    fetchData();

  }

  Future<void> fetchData() async {
    try {

      if(widget.userId != null) {
        postResult = await _postProvider.getPaged(filter: {"userId": widget.userId});
      }

      if(widget.groupId !=null){
        postResult = await _postProvider.getPaged(filter: {"groupId": widget.groupId});
      }

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

    fetchedPosts = postResult!.items;
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading ? const SpinKitFadingCircle(color: Colors.lightGreen) :
    Scaffold(
      appBar: AppBar(
        title: Text("${widget.username ?? widget.groupname ?? "blank'"} posts"),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: fetchedPosts!.length,
              itemBuilder: (context, index){
                return PostWidget(
                    id: fetchedPosts![index].id!,
                    title: fetchedPosts![index].title!,
                    content: fetchedPosts![index].text!,
                    isAdvert: fetchedPosts![index].isAdvert!,
                    groupId: fetchedPosts![index].groupId!,
                    groupName: fetchedPosts![index].group!.name!,
                    user: fetchedPosts![index].user!,
                    tag: fetchedPosts![index].tag,
                    images: fetchedPosts![index].images);
              }
            )
          ]
        ),
      ),
    );
  }
}
