import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/models/search_result.dart';
import 'package:provider/provider.dart';

import '../models/comment.dart';
import '../models/like.dart';
import '../models/tag.dart';
import '../models/user.dart';
import '../providers/comment_provider.dart';
import '../providers/like_provider.dart';
import '../utils/utils.dart';

class PostWidget extends StatefulWidget {
  //const PostWidget({super.key});

  final int id;
  final String title;
  final String content;
  final String group;
  final User user;
  final Tag? tag;

  const PostWidget(
      {required this.id,
      required this.title,
      required this.content,
      required this.group,
      required this.user,
      this.tag,
      super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late CommentProvider _commentProvider = CommentProvider();
  SearchResult<Comment>? commentResult;
  List<Comment>? comments;

  late LikeProvider _likeProvider = LikeProvider();
  SearchResult<Like>? likeResult;
  List<Like>? likes;

  SearchResult<Like>? myLike;

  bool isLoading = true;

  bool visibleComments = false;

  final TextEditingController _commentController = TextEditingController();


  @override
  void initState() {
    super.initState();

    _commentProvider = context.read<CommentProvider>();
    _likeProvider = context.read<LikeProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await fetchComments();
      await fetchLikes();
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

  Future<void> fetchComments() async {
    try {
      commentResult = await _commentProvider
          .getPaged(filter: {"pageSize": 100, "postId": widget.id});
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
    setState(() {
      comments = commentResult!.items;
    });
  }

  Future<void> fetchLikes() async {
    try {
        likeResult = await _likeProvider
            .getPaged(filter: {"pageSize": 100, "postId": widget.id});
        myLike = await _likeProvider.getPaged(filter: {
          "postId": widget.id,
          "userId": Authentification.tokenDecoded?["Id"]
        });
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
    if (likeResult == null) {
      likes = [];
    } else {
      setState(() {
        likes = likeResult!.items;
      });
    }
    setState(() {
      myLike=myLike;
    });
  }

  List<Widget> renderComments() {
    List<Widget> result = [];

    result.add(
      const Divider(
        thickness: 6,
      ),
    );

    if (comments == null || comments!.isEmpty == true) {
      result.add(Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "No comments",
            style: kTileContentStyle,
          )));
    } else {
      for (var i = 0; i < comments!.length; i++) {
        result.add(Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 4.0, right: 4.0, bottom: 2.0),
                  child: Text(
                    comments![i].user!.username!,
                    style: kTileSubtitleStyle,
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 4.0, right: 4.0, bottom: 2.0),
                  child: Text(
                    comments![i].text!,
                    style: kTileContentStyle,
                  ),
                ))
          ],
        ));
      }
    }

    result.add(TextFormField(
      controller: _commentController,
      onFieldSubmitted: submitComment,
      decoration: const InputDecoration(
        labelText: "Add a comment",
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ));

    return result;
  }

  Future<void> appendLike(bool likeOrDislike) async {
    Like newLike;
    int userID = int.parse(Authentification.tokenDecoded?["Id"]);

    if (myLike==null || myLike!.items.isEmpty) {
      newLike = Like(null, likeOrDislike, widget.id, userID);
    } else {
      newLike = Like(myLike!.items[0].id, likeOrDislike, widget.id, userID);
    }

    try {

      if (myLike==null || myLike!.items.isEmpty){
        await _likeProvider.insert(newLike);
      }
      else if (myLike!.items[0].type==!likeOrDislike){
        await _likeProvider.update(newLike);
      }
      else if (myLike!.items[0].type==likeOrDislike){
        await _likeProvider.remove(myLike!.items[0].id!);
      }

    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }
    await fetchLikes();


  }

  Future<void> submitComment (String comment) async{

    int userID = int.parse(Authentification.tokenDecoded?["Id"]);
    Comment? newComment = Comment(null,comment, userID, null, widget.id);

    try{
      await _commentProvider.insert(newComment);
    }catch(e){
      if (mounted) {
        alertBoxMoveBack(context, "Error", e.toString());
      }
    }

    fetchComments();
    _commentController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 200, 200, 200),
                    Color.fromARGB(255, 234, 234, 234)
                  ]),
                  //color: Color.fromARGB(255, 234, 234, 234),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: null,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      //await Get.find<RoomsController>().joinRoom(room: room);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "${widget.group}  Tag: ${widget.tag?.name ?? ""}",
                                  style: kTileSubtitleStyle),
                              const Spacer(),
                              const Icon(
                                Icons.more_horiz,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.title,
                            maxLines: 3,
                            style: kTileTitleStyle,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          //buildTags(),
                          Text(
                            widget.content,
                            style: kTileContentStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 222, 222, 222),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Row(
                            children: [
                              Text(widget.user.username!,
                                  style: kTileSubtitleStyle),
                              const Spacer(),
                              IconButton(
                                tooltip: "Show comments",
                                onPressed: () {
                                  setState(() {
                                    visibleComments = !visibleComments;
                                  });
                                },
                                icon: Icon(
                                  Icons.chat_bubble,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              Text(comments!.length.toString()),
                              SizedBox(
                                width: 6,
                              ),
                              IconButton(
                                onPressed: () {appendLike(true);},
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: myLike!.items.isEmpty
                                      ? Colors.black
                                      : myLike!.items[0].type == true
                                          ? Colors.blue
                                          : Colors.black,
                                  size: 20,
                                ),
                              ),
                              Text(likes!
                                  .where((l) => l.type == true)
                                  .toList()
                                  .length
                                  .toString()),
                              IconButton(
                                onPressed: () {appendLike(false);},
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: myLike!.items.isEmpty
                                      ? Colors.black
                                      : myLike!.items[0].type == false
                                          ? Colors.red
                                          : Colors.black,
                                  size: 20,
                                ),
                              ),
                              Text(likes!
                                  .where((l) => l.type == false)
                                  .toList()
                                  .length
                                  .toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    height: (visibleComments ? 1 : 0) *
                        ((comments == null || comments!.isEmpty)
                            ? 90.0
                            : comments!.length * 110.0),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: renderComments(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

var kTileTitleStyle = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);
var kTileSubtitleStyle =
    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
var kTileContentStyle = const TextStyle(
    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
