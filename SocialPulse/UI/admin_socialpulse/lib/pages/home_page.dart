import 'package:admin_socialpulse/pages/account_page.dart';
import 'package:admin_socialpulse/pages/commentsView_page.dart';
import 'package:admin_socialpulse/pages/dashboard_page.dart';
import 'package:admin_socialpulse/pages/groupsView_page.dart';
import 'package:admin_socialpulse/pages/login_page.dart';
import 'package:admin_socialpulse/pages/postsView_page.dart';
import 'package:admin_socialpulse/pages/qna_page.dart';
import 'package:admin_socialpulse/pages/tagsView_page.dart';
import 'package:admin_socialpulse/pages/usersView_page.dart';
import 'package:admin_socialpulse/pages/notificationsView_page.dart';
import 'package:admin_socialpulse/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = [
    const DashboardPage(),
    const UsersViewPage(),
    const PostsViewPage(),
    const CommentsViewPage(),
    const GroupsViewPage(),
    const TagsViewPage(),
    const QnAPage(),
    const NotificationsViewPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 251, 254, 1),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Social Pulse",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
              ),
              drawerListTile(
                  title: ' Dash Board',
                  icon: const Icon(Icons.dashboard),
                  tap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  index: _currentIndex == 0),
              drawerListTile(
                  title: ' Users',
                  icon: const Icon(Icons.person),
                  tap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  index: _currentIndex == 1),
              drawerListTile(
                  title: ' Posts',
                  icon: const Icon(Icons.messenger),
                  tap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                  index: _currentIndex == 2),
              drawerListTile(
                  title: ' Comments',
                  icon: const Icon(Icons.messenger),
                  tap: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                  index: _currentIndex == 3),
              drawerListTile(
                  title: ' Groups',
                  icon: const Icon(Icons.circle),
                  tap: () {
                    setState(() {
                      _currentIndex = 4;
                    });
                  },
                  index: _currentIndex == 4),
              drawerListTile(
                  title: ' Tags',
                  icon: const Icon(Icons.tag),
                  tap: () {
                    setState(() {
                      _currentIndex = 5;
                    });
                  },
                  index: _currentIndex == 5),
              drawerListTile(
                  title: ' QnA',
                  icon: const Icon(Icons.question_answer),
                  tap: () {
                    setState(() {
                      _currentIndex = 6;
                    });
                  },
                  index: _currentIndex == 6),
              drawerListTile(
                  title: ' Notifications',
                  icon: const Icon(Icons.note),
                  tap: () {
                    setState(() {
                      _currentIndex = 7;
                    });
                  },
                  index: _currentIndex == 7),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(
                  color: Color.fromRGBO(148, 170, 220, 1),
                  thickness: 0.2,
                ),
              ),
              drawerListTile(
                  title: ' Account',
                  icon: const Icon(Icons.person),
                  tap: () {
                    setState(() {
                      _currentIndex = 8;
                    });
                  },
                  index: _currentIndex == 8),
              drawerListTile(
                  title: ' Logout',
                  icon: const Icon(Icons.logout),
                  tap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text("Log out"),
                              content: const Text(
                                  "Are you sure you want to log out?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      try {
                                        Authentification.token = '';

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const LoginPage()),
                                            (route) => false);
                                      } catch (e) {
                                        alertBoxMoveBack(
                                            context, "Error", e.toString());
                                      }
                                    },
                                    child: const Text(
                                      "Confirm",
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            ));
                  },
                  index: false),
            ],
          )),
          const VerticalDivider(
            width: 20,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          Expanded(
            flex: 5,
            child: body[_currentIndex],
          )
        ],
      ),
    );
  }
}

ListTile drawerListTile(
    {required String title,
    required Icon icon,
    required VoidCallback tap,
    required bool index}) {
  return ListTile(
    onTap: tap,
    horizontalTitleGap: 0.0,
    leading: icon,
    tileColor: index ? const Color.fromARGB(255, 219, 217, 217) : null,
    title: Text(
      title,
      style: const TextStyle(color: Color.fromRGBO(148, 170, 220, 1)),
    ),
  );
}
