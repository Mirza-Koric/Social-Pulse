
import 'package:flutter/material.dart';

import '../utils/chatBubble.dart';
import '../utils/utils.dart';

import 'package:mobile_socialpulse/models/image.dart' as myImage;


class ReceivedMessage  extends StatelessWidget {
  final Widget child;
  final String time;
  final List<myImage.Image>? images;
  const ReceivedMessage ({
    Key? key,
    required this.child, required this.time, this.images
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft , //Change this to Alignment.topRight or Alignment.topLeft
              child: Column(
                children: [
                  CustomPaint(
                    painter: ChatBubble(color: const Color(0xffF2F2F2), alignment: Alignment.topLeft ),
                    child: Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 0.6 * MediaQuery.of(context).size.width),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                        child: child,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const CustomHeightSpacer(size: 0.008,),

            images == null || images == [] || images!.isEmpty
                ? const SizedBox():
            Row(
              children: [
                SizedBox(
                  height: 150,
                  width: 200,
                  child: ListView.builder(
                      itemCount: images!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return imageFromBase64String2(images![index].data!);
                      }
                  ),
                ),
                const Spacer(),
              ],
            ),

            Row(children: [
              Text(
                time,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.2575,
                  letterSpacing: 1,
                  color: Color(0xff77838f),
                ),
              ),
              const Spacer(),
            ],)
          ],
        ));

    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          messageTextGroup,
          const SizedBox(height: 30),

        ],
      ),
    );
  }
}