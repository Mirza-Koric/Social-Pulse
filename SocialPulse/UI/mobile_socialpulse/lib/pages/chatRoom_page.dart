import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_socialpulse/models/conversation.dart';
import 'package:mobile_socialpulse/models/message.dart';
import 'package:mobile_socialpulse/providers/conversation_provider.dart';
import 'package:mobile_socialpulse/providers/message_provider.dart';
import 'package:mobile_socialpulse/utils/utils.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';
import '../widgets/receivedMessageWidget.dart';
import '../widgets/sentMessageWidget.dart';

class ChatRoomPage extends StatefulWidget {
  //const ChatRoomPage({Key? key,}) : super(key: key);

  final int userId;
  final int userId2;

  const ChatRoomPage({required this.userId, required this.userId2, super.key});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

  late ConversationProvider _conversationProvider = ConversationProvider();
  SearchResult<Conversation>? conversationResult;
  List<Message>? messages;
  
  late MessageProvider _messageProvider = MessageProvider();

  String? otherUsername;
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();

  List<String>? images;
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
  void initState() {
    super.initState();

    _conversationProvider = context.read<ConversationProvider>();
    _messageProvider = context.read<MessageProvider>();

    fetchData();
  }

  Future<void> fetchData() async {
    try {
      conversationResult =
        await _conversationProvider.getPaged(
            filter: {"pageSize": 1000, "userId":widget.userId, "userId2":widget.userId2}
        );
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

    if(conversationResult!.totalCount > 0) {
      messages = conversationResult!.items[0].messages;

      //getting the name of the user we are chatting with
      for (var x in conversationResult!.items[0].users!) {
        if (x.userId != int.parse(Authentification.tokenDecoded?["Id"])) {
          otherUsername = x.user!.username;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      isLoading ? const SpinKitFadingCircle(color: Colors.lightGreen) :
      Scaffold(
      appBar: AppBar(
        title: Text(otherUsername ?? "placeholder", style: const TextStyle(fontSize: 24),),
        surfaceTintColor: Colors.transparent,
      ),
      body:
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: (messages==null || messages!.isEmpty) ? const Text("Send a message") :
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: messages!.length,
                  itemBuilder: (context, index){
                    return
                        messages![index].userId==int.parse(Authentification.tokenDecoded?["Id"])?
                        SentMessage(
                            time: formatDate(
                                messages![index].createdAt!,
                                [h, ':', nn, am]),
                            images: messages![index].images,
                            child:  Text(
                              messages![index].text!,
                              style: sentStyle(),
                            )) :
                        ReceivedMessage(
                            time:formatDate(
                                messages![index].createdAt!,
                                [h, ':', nn, am]),
                            images: messages![index].images,
                            child:  Text(
                              messages![index].text!,
                              style: receivedStyle(),
                            ));
                  }),
            ),
          ),

          Column(
            children: [
              images == null || images == []
                  ? Container():
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200, maxWidth: 350),
                    child: ListView.builder(
                        itemCount: images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return imageFromBase64String(images![index]);
                        }
                    ),
                  ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 0, bottom: 0, top: 0),
                  height: 70,
                  color: const Color(0xffF2F2F2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        images == null || images == [] ?
                        IconButton(
                          onPressed: getImage,
                          icon: const Icon(Icons.image, size: 28, color: Colors.black)
                        ):
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  images=null;
                                  _images=null;
                                  _base64Images=null;
                                });
                              },
                              icon: const Icon(Icons.close, size: 28, color: Colors.black)),
                        Expanded(
                          child: SizedBox(
                              height: 50,
                              width: 100,
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  validator: (value){
                                    if(value != null && value.isNotEmpty)
                                      {
                                        return null;
                                      }
                                    else {
                                      return "Please enter message text";
                                    }
                                  },
                                  controller: _messageController,
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Message"
                                  ),
                                ),
                              )),
                        ),
                        IconButton(
                            onPressed: () async {

                              //Message newMessage = Message(0, _messageController.text, int.parse(Authentification.tokenDecoded?["Id"]), conversationResult!.items[0].id, null, null);

                              if(_formKey.currentState != null && _formKey.currentState!.validate()) {
                                var newMessage = {
                                  'id': 0,
                                  'text': _messageController.text,
                                  'userId': int.parse(
                                      Authentification.tokenDecoded?["Id"]),
                                  'conversationId': conversationResult!.items[0]
                                      .id,

                                };

                                dynamic messageImages;

                                if (images != null &&
                                    images!.isEmpty == false) {
                                  messageImages = [];

                                  for (var image in images!) {
                                    messageImages.add({
                                      "data": image,
                                      "contentType": "image"
                                    });
                                  }

                                  newMessage['images'] = messageImages;
                                }

                                try {
                                  await _messageProvider.insert(newMessage);
                                } catch (e) {
                                  if (mounted) {
                                    alertBoxMoveBack(
                                        context, "Error", e.toString());
                                  }
                                }

                                setState(() {
                                  images = null;
                                  _images = null;
                                  _base64Images = null;
                                });
                                _messageController.clear();
                                fetchData();

                              }
                            },
                            icon: const Icon(Icons.send, size: 28, color: Colors.black))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class DateDevider extends StatelessWidget {
  const DateDevider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UnconstrainedBox(
      child: Center(
          child: Text(
            '1/25/24',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.193359375,
              letterSpacing: 1,
              color: Color(0xff77838f),
            ),
          )),
    );
  }
}

TextStyle sentStyle ()
{
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6428571429,
    letterSpacing: 0.5,
    color: Color(0xffffffff),
  );
}

TextStyle receivedStyle ()
{
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6428571429,
    letterSpacing: 0.5,
    color: Color(0xff323643),
  );
}