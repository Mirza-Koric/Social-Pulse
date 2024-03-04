import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/pages/profile_page.dart';
import 'package:mobile_socialpulse/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/post_provider.dart';
import '../widgets/postWidget.dart';
import '../utils/utils.dart';
import 'createPost_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = [
    const Text("placeholder"),
    const CreatePostPage(),
    const ProfilePage(),
  ];

  late UserProvider _userProvider = UserProvider();
  User? userResult;

  late PostProvider _postProvider = PostProvider();
  SearchResult<Post>? postResult;
  List<Post>? fetchedPosts;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _postProvider = context.read<PostProvider>();
    _userProvider = context.read<UserProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      userResult = await _userProvider.getById(int.parse(Authentification.tokenDecoded?["Id"]));
      bool? isSubscribed = userResult!.subscription?.active;

      postResult = await _postProvider.getPaged(
          filter: {
            'pageSize':10,
            'isAdvert': isSubscribed==null ? null : isSubscribed==false ? null : false});

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
    body[0]=SingleChildScrollView(child: Column(children: generatePosts()));

  }

  List<PostWidget> generatePosts() {
    List<PostWidget> posts = [];

    for (var i = 0; i < fetchedPosts!.length; i++) {
      posts.add(PostWidget(
          id: fetchedPosts![i].id!,
          content: fetchedPosts![i].text!,
          title: fetchedPosts![i].title!,
          isAdvert: fetchedPosts![i].isAdvert!,
          groupId: fetchedPosts![i].groupId!,
          groupName: fetchedPosts![i].group!.name!,
          user: fetchedPosts![i].user!,
          tag: fetchedPosts![i].tag,
          images: fetchedPosts![i].images));
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 234, 242, 245),
            appBar: AppBar(
              title: const Text("Welcome!"),
              centerTitle: true,
            ),
            body: body[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
                fetchData();
              },
              items: const [
                BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: "Create", icon: Icon(Icons.add)),
                BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person))
              ],
            ),
          );
  }
}
