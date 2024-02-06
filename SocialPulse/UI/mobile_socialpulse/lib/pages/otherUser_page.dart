import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/models/user_conversation.dart';
import 'package:mobile_socialpulse/pages/listPosts_page.dart';
import 'package:provider/provider.dart';

import '../models/conversation.dart';
import '../models/search_result.dart';
import '../models/user.dart';
import '../providers/conversation_provider.dart';
import '../providers/user_provider.dart';
import '../utils/utils.dart';
import 'chatRoom_page.dart';

class OtherUser extends StatefulWidget {
  //const OtherUser({super.key});

  final int id;

  const OtherUser({required this.id, super.key});

  @override
  State<OtherUser> createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  bool isLoading = true;
  int loggedUserId = int.parse(Authentification.tokenDecoded?["Id"]);

  late UserProvider _userProvider = UserProvider();
  User? userResult;

  late ConversationProvider _conversationProvider = ConversationProvider();
  SearchResult<Conversation>? conversationResult;

  @override
  void initState() {
    super.initState();

    _userProvider = context.read<UserProvider>();
    _conversationProvider = context.read<ConversationProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      userResult = await _userProvider
          .getById(widget.id);

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
    final screenWidth = MediaQuery.of(context).size.width;

    return isLoading ? const SpinKitFadingCircle(color: Colors.lightGreen) :
    Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xFFEAF2F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth * 0.9,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF8c981a),
                ),
                child:  Center(
                  child: Text(
                    "${userResult!.username!}'s profile",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xFFFFF3E5),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 5.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Color(0xFF8C981A),
                              size: 30,
                            ),
                            const SizedBox(width: 10.0), Text(
                              userResult!.username!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF444444)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.mail_outline,
                              color: Color(0xFF8C981A),
                              size: 30,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              userResult!.email!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF444444)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.cake,
                              color: Color(0xFF8C981A),
                              size: 30,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              formatDate(
                                  userResult!.birthDate!,
                                  [d, '.', m, '.', yyyy]),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF444444)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03),
              child: Column(
                children: [
                  Row(
                    children: [
                      customContainer(
                          TextButton.icon(
                            onPressed: () async{

                              try {
                                conversationResult =
                                await _conversationProvider.getPaged(
                                    filter: {
                                      "pageSize": 1000,
                                      "userId": loggedUserId,
                                      "userId2": widget.id
                                    }
                                );

                                if (conversationResult!.items.isEmpty) {

                                  Conversation newConvo = Conversation(0, null, [
                                    UserConversation(0, loggedUserId, null, 0, null),
                                    UserConversation(0, widget.id, null, 0, null)
                                  ]);

                                  await _conversationProvider.insert(newConvo);
                                }

                              }catch(e){
                                if (mounted) {
                                  alertBoxMoveBack(context, "Error", e.toString());
                                }
                              }

                              if(mounted) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatRoomPage(
                                        userId: loggedUserId,
                                        userId2: widget.id)));
                              }
                            },
                            icon: const Icon(Icons.question_answer, color: Color(0xFF394949),),
                            label: const Text("Chat", style: TextStyle(color: Colors.black)),
                          )
                      ),

                      customContainer(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=> PostsList(userId: widget.id, username: userResult!.username!,)));
                                },
                                icon: const Icon(Icons.chat_bubble_rounded, color: Color(0xFF394949)),
                                label: const Text("Posts", style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Container customContainer(Widget child) {
  return Container(
    margin: const EdgeInsets.only(left: 15,top: 15, right: 15, bottom: 5),
    padding: const EdgeInsets.all(15),
    width: 160,
    decoration: BoxDecoration(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: child,
  );
}
