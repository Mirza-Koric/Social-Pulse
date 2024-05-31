import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/models/search_result.dart';
import 'package:mobile_socialpulse/providers/user_provider.dart';
import 'package:mobile_socialpulse/widgets/postWidget.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/recommend_result.dart';
import '../models/user.dart';
import '../providers/post_provider.dart';
import '../providers/recommend_result_provider.dart';
import '../utils/utils.dart';

class PostPage extends StatefulWidget {
  final int postId;

  const PostPage({required this.postId, super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late PostProvider _postProvider = PostProvider();
  Post? postResult;
  SearchResult<Post>? randomResult;
  List<Post>? randomPosts;

  late UserProvider _userProvider = UserProvider();
  User? userResult;
  bool? isSubscribed;

  late RecommendResultProvider _recommendResultProvider =
      RecommendResultProvider();
  RecommendResult? recommendResult;

  Post? recommendPostOne;
  Post? recommendPostTwo;
  Post? recommendPostThree;

  bool isLoading = true;
  bool loadingRecommendations = true;

  bool recommendExists = false;

  @override
  void initState() {
    super.initState();

    _postProvider = context.read<PostProvider>();
    _recommendResultProvider = context.read<RecommendResultProvider>();

    fetchData();
    fetchRecommendations();


  }

  Future<void> fetchData() async {
    try {
      postResult = await _postProvider.getById(widget.postId);
      userResult = await _userProvider.getById(int.parse(Authentification.tokenDecoded?["Id"]));
      isSubscribed = userResult!.subscription?.active;

      randomResult = await _postProvider.getRandom();
      randomPosts = randomResult?.items;

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

  Future<void> fetchRecommendations() async {
    try {
      recommendResult = await _recommendResultProvider.getById(widget.postId);

      if (recommendResult != null) {
        bool first =
            await _postProvider.exists(recommendResult!.firstCopostId!);
        bool second =
            await _postProvider.exists(recommendResult!.secondCopostId!);
        bool third =
            await _postProvider.exists(recommendResult!.thirdCopostId!);
        if (!(first == false && second == false && third == false)) {
          setState(() {
            recommendExists = true;
          });

          recommendPostOne =
              await _postProvider.getById(recommendResult!.firstCopostId!);
          recommendPostTwo =
              await _postProvider.getById(recommendResult!.secondCopostId!);
          recommendPostThree =
              await _postProvider.getById(recommendResult!.thirdCopostId!);
        }
      }

      setState(() {
        loadingRecommendations = false;
      });
    } catch (e) {
      recommendResult = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
            ),
            backgroundColor: const Color(0xFFEAF2F4),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  PostWidget(
                    id: postResult!.id!,
                    title: postResult!.title!,
                    content: postResult!.text!,
                    isAdvert: postResult!.isAdvert!,
                    groupId: postResult!.groupId!,
                    groupName: postResult!.group!.name!,
                    user: postResult!.user!,
                    tag: postResult!.tag,
                    images: postResult!.images,
                    showComments: true,
                    isPostPage: true,
                  ),
                  const SizedBox(height: 15),
                  const Text("You might also like", style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  (loadingRecommendations == true || recommendExists == false || recommendResult == null)
                      ?
                      ListView.builder(
                          itemCount: randomPosts?.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                PostWidget(
                                    id: randomPosts![index].id!,
                                    title: randomPosts![index].title!,
                                    content: randomPosts![index].text!,
                                    isAdvert: randomPosts![index].isAdvert!,
                                    groupId: randomPosts![index].groupId!,
                                    groupName: randomPosts![index].group!.name!,
                                    user: randomPosts![index].user!,
                                    tag: randomPosts![index].tag,
                                    images: randomPosts![index].images
                                ),
                                const SizedBox(height: 10),
                             ],
                          );
                        })
                      : Column(
                          children: [
                            (isSubscribed == true && recommendPostOne!.isAdvert==true) ? const SizedBox() :
                            PostWidget(
                                id: recommendPostOne!.id!,
                                title: recommendPostOne!.title!,
                                content: recommendPostOne!.text!,
                                isAdvert: recommendPostOne!.isAdvert!,
                                groupId: recommendPostOne!.groupId!,
                                groupName: recommendPostOne!.group!.name!,
                                user: recommendPostOne!.user!,
                                tag: recommendPostOne!.tag,
                                images: recommendPostOne!.images),
                            const SizedBox(height: 10),
                            (isSubscribed == true && recommendPostTwo!.isAdvert==true) ? const SizedBox() :
                            PostWidget(
                                id: recommendPostTwo!.id!,
                                title: recommendPostTwo!.title!,
                                content: recommendPostTwo!.text!,
                                isAdvert: recommendPostTwo!.isAdvert!,
                                groupId: recommendPostTwo!.groupId!,
                                groupName: recommendPostTwo!.group!.name!,
                                user: recommendPostTwo!.user!,
                                tag: recommendPostTwo!.tag,
                                images: recommendPostTwo!.images),
                            const SizedBox(height: 10),
                            (isSubscribed == true && recommendPostThree!.isAdvert==true) ? const SizedBox() :
                            PostWidget(
                                id: recommendPostThree!.id!,
                                title: recommendPostThree!.title!,
                                content: recommendPostThree!.text!,
                                isAdvert: recommendPostThree!.isAdvert!,
                                groupId: recommendPostThree!.groupId!,
                                groupName: recommendPostThree!.group!.name!,
                                user: recommendPostThree!.user!,
                                tag: recommendPostThree!.tag,
                                images: recommendPostThree!.images),
                          ],
                        ),
                ],
              ),
            ),
          );
  }
}
