import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/conversation.dart';
import '../models/search_result.dart';
import '../providers/conversation_provider.dart';
import '../utils/utils.dart';
import 'chatRoom_page.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late ConversationProvider _conversationProvider = ConversationProvider();
  SearchResult<Conversation>? conversationResult;
  List<Conversation>? conversations;

  int loggedUserId = int.parse(Authentification.tokenDecoded?["Id"]);
  bool isLoading = true;
  List<String> conversationPartners = [];
  List<int> conversationPartnersId = [];
  List<String> latestMessages = [];

  @override
  void initState() {
    super.initState();

    _conversationProvider = context.read<ConversationProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      conversationResult = await _conversationProvider.getPaged(filter: {
        "pageSize": 1000,
        "userId": Authentification.tokenDecoded?["Id"]
      });
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

    conversations = conversationResult!.items;

    for(var x in conversationResult!.items)
    {
      var temp = x.users!.where((element) => element.userId != loggedUserId);
      conversationPartners.add(temp.first.user!.username!);
      conversationPartnersId.add(temp.first.user!.id!);
    }

    for (var x in conversations!)
      {
        var latestMessage = x.messages!.reduce((value, element) =>
            value.createdAt!.isAfter(element.createdAt!) ?value : element).text!;
        latestMessages.add(latestMessage);
      }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SpinKitFadingCircle(color: Colors.lightGreen)
        : Scaffold(
            appBar: AppBar(
              title: const Text("Messages"),
            ),
            backgroundColor: const Color(0xFFEAF2F4),
            body: Column(
              children: [
                conversationResult==null || conversationResult!.items.isEmpty ?
                const Text("No active chats", style: TextStyle(fontSize: 28))
                :Expanded(
                    child: ListView.builder(
                      itemCount: conversationResult!.items.length,
                      shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChatRoomPage(userId: int.parse(Authentification.tokenDecoded?["Id"]),userId2: conversationPartnersId[index])));
                              },
                              child: customContainer(
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(conversationPartners[index], style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                    Text(latestMessages[index], style: const TextStyle(fontSize: 20))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))
              ],
            ),
          );
  }
}


Container customContainer(Widget child) {
  return Container(
    margin: const EdgeInsets.only(left: 5,top: 5, right: 5, bottom: 0),
    padding: const EdgeInsets.all(15),
    width: 160,
    decoration: BoxDecoration(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(15),
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


// for(var x in conversationResult!.items)
// {
// // for(var y in x.users!)
// //   {
// //     if(y.userId != loggedUserId)
// //       {
// //         print(y.user!.username);
// //       }
// //   }
//
// var temp = x.users!.where((element) => element.userId != loggedUserId).first.user!.username;
// print(temp);
// }
