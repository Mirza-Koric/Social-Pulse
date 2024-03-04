import 'dart:ui';

import 'package:admin_socialpulse/models/comment.dart';
import 'package:admin_socialpulse/models/post.dart';
import 'package:admin_socialpulse/models/search_result.dart';
import 'package:admin_socialpulse/models/subscription.dart';
import 'package:admin_socialpulse/models/user.dart';
import 'package:admin_socialpulse/providers/comment_provider.dart';
import 'package:admin_socialpulse/providers/post_provider.dart';
import 'package:admin_socialpulse/providers/subscription_provider.dart';
import 'package:admin_socialpulse/providers/user_provider.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLoading = true;
  var today = DateTime.now();
  //var lastWeek = DateTime(today.year,today.month,today.day)

  late UserProvider _userProvider = UserProvider();
  late PostProvider _postProvider = PostProvider();
  late CommentProvider _commentProvider = CommentProvider();
  late SubscriptionProvider _subscriptionProvider = SubscriptionProvider();

  late SearchResult<User>? userResultWeek;
  late SearchResult<User>? userResultMonth;
  late SearchResult<User>? userResultYear;

  late SearchResult<Post>? postResultWeek;
  late SearchResult<Post>? postResultMonth;
  late SearchResult<Post>? postResultYear;

  late SearchResult<Comment>? commentResultWeek;
  late SearchResult<Comment>? commentResultMonth;
  late SearchResult<Comment>? commentResultYear;

  late SearchResult<Subscription>? subscriptionResultWeek;
  late SearchResult<Subscription>? subscriptionResultMonth;
  late SearchResult<Subscription>? subscriptionResultYear;

  late SearchResult<User>? userResultDeleted;
  late SearchResult<Post>? postResultDeleted;
  late SearchResult<Comment>? commentResultDeleted;
  late SearchResult<Subscription>? subscriptionResultDeleted;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _postProvider = context.read<PostProvider>();
    _commentProvider = context.read<CommentProvider>();
    _subscriptionProvider = context.read<SubscriptionProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      userResultWeek = await _userProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month, today.day - 7)
      });
      userResultMonth = await _userProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month - 1, today.day)
      });
      userResultYear = await _userProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year - 1, today.month, today.day)
      });
      userResultDeleted = await _userProvider
          .getPaged(filter: {'isDeleted': true, 'pageSize': 10000});

      postResultWeek = await _postProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month, today.day - 7)
      });
      postResultMonth = await _postProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month - 1, today.day)
      });
      postResultYear = await _postProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year - 1, today.month, today.day)
      });
      postResultDeleted = await _postProvider
          .getPaged(filter: {'isDeleted': true, 'pageSize': 10000});

      commentResultWeek = await _commentProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month, today.day - 7)
      });
      commentResultMonth = await _commentProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month - 1, today.day)
      });
      commentResultYear = await _commentProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year - 1, today.month, today.day)
      });
      commentResultDeleted = await _commentProvider
          .getPaged(filter: {'isDeleted': true, 'pageSize': 10000});

      subscriptionResultWeek = await _subscriptionProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month, today.day - 7)
      });
      subscriptionResultMonth = await _subscriptionProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year, today.month - 1, today.day)
      });
      subscriptionResultYear = await _subscriptionProvider.getPaged(filter: {
        'isDeleted': false,
        'pageSize': 10000,
        'createdAt': DateTime(today.year - 1, today.month, today.day)
      });
      subscriptionResultDeleted = await _subscriptionProvider
          .getPaged(filter: {'isDeleted': true, 'pageSize': 10000});

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 40, 20),
        child: isLoading == true
            ? const Center(child: SpinKitFadingCircle(color: Colors.lightGreen))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Active",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 166,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _customCard(
                                "Users",
                                userResultWeek!.items.length,
                                userResultMonth!.items.length,
                                userResultYear!.items.length),
                            const SizedBox(
                              width: 30,
                            ),
                            _customCard(
                                "Posts",
                                postResultWeek!.items.length,
                                postResultMonth!.items.length,
                                postResultYear!.items.length),
                            const SizedBox(
                              width: 30,
                            ),
                            _customCard(
                                "Comments",
                                commentResultWeek!.items.length,
                                commentResultMonth!.items.length,
                                commentResultYear!.items.length),
                            const SizedBox(
                              width: 30,
                            ),
                            _customCard(
                                "Subscriptions",
                                subscriptionResultWeek!.items.length,
                                subscriptionResultMonth!.items.length,
                                subscriptionResultYear!.items.length),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Deleted",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 166,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _customCard2(
                                "Users", userResultDeleted!.items.length),
                            const SizedBox(
                              width: 30,
                            ),
                            _customCard2(
                                "Posts", postResultDeleted!.items.length),
                            const SizedBox(
                              width: 30,
                            ),
                            _customCard2(
                                "Comments", commentResultDeleted!.items.length),
                            const SizedBox(
                              width: 30,
                            ),
                            _customCard2("Subscriptions",
                                subscriptionResultDeleted!.items.length),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Card _customCard(String title, int dayCount, int weekCount, int monthCount) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 250,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 23, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Past week: $dayCount',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Past month: $weekCount',
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(
                height: 10,
              ),
              Text('Past year: $monthCount',
                  style: const TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  Card _customCard2(String title, int count) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 250,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 23, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Deleted: $count',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
