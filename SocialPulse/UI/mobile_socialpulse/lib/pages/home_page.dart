
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../models/search_result.dart';
import '../providers/post_provider.dart';
import '../widgets/postWidget.dart';
import '../utils/utils.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.add),
    Icon(Icons.person),
  ];

  late PostProvider _postProvider = PostProvider();
  SearchResult<Post>? postResult;
  List<Post>? fetchedPosts;
  bool isLoading = true;

  @override
  void  initState() {
    super.initState();

    _postProvider = context.read<PostProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
        postResult = await _postProvider.getPaged();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
    } catch (e) {
      if (mounted) {
        alertBoxMoveBack(
            context, "Error", e.toString());
      }
    }

    fetchedPosts=postResult!.items;
  }

  List<PostWidget> tenPosts()
  {
    List<PostWidget> posts = [];

    for (var i = 0; i < 10; i++) {
      posts.add(PostWidget(
          id:fetchedPosts![i].id!,
          content:fetchedPosts![i].text!,
          title: fetchedPosts![i].title!,
          group: fetchedPosts![i].group!.name!,
          user: fetchedPosts![i].user!,
          tag: fetchedPosts![i].tag));
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return
      isLoading ? const SpinKitFadingCircle(color: Colors.lightGreen) :
      Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 242, 245),
      appBar: AppBar(
        title: const Text("Welcome!"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: tenPosts(),
          // children: [PostWidget(
          //     id:fetchedPosts![0].id!,
          //     content:fetchedPosts![0].text!,
          //     title: fetchedPosts![0].title!,
          //     group: fetchedPosts![0].group!.name!,
          //     user: fetchedPosts![0].user!,
          //     tag: fetchedPosts![0].tag)],
          // children: [
          //   FilledButton(onPressed: ()=>{print(fetchedPosts![0].title)}, child: Text("Press"))
          // ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
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
