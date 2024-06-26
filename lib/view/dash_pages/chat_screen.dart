import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/chat_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/view/dash_pages/messages_screen.dart';
import 'package:petwarden/widgets/chat_tile.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ChatScreen extends StatelessWidget {
  final c = Get.find<ChatController>();
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Messages",
            style: CustomTextStyles.f22W600(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Expanded(child: _buildChatRooms()),
            // Expanded(
            //     child: CustomElevatedButton(
            //   title: "text",
            //   onPressed: () {
            //     print(c.cc.currentUser.value!.id);
            //     // Get.toNamed(MessagesScreen.routeName, arguments: {
            //     //   "reciverdetail": {"id": "15", "name": "Anu", "chatRoomId": "4_15"}
            //     // });
            //   },
            // ))
          ]),
        ));
  }

  Widget _buildChatRooms() {
    return StreamBuilder(
      stream: c.getChatRooms(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView.separated(
          separatorBuilder: (context, builder) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                width: Get.width,
                color: PetWardenColors.borderColor,
              ),
            );
          },
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            var timeField = c.formatTimestamp(data["timestamp"]);
            bool isReceiver =
                c.user.value?.name?.toLowerCase() == data["receiverName"].toString().toLowerCase();
            return InkWell(
              radius: 24,
              onTap: () {
                if (isReceiver) {
                  Get.toNamed(MessagesScreen.routeName, arguments: {
                    "reciverdetail": {
                      "id": data["senderId"],
                      "name": data["senderName"],
                      "chatRoomId": data["chatRoomId"],
                      "image": data["senderImage"]
                    }
                  });
                } else {
                  Get.toNamed(MessagesScreen.routeName, arguments: {
                    "reciverdetail": {
                      "id": data["receiverId"],
                      "name": data["receiverName"],
                      "chatRoomId": data["chatRoomId"],
                      "image": data["receiverImage"]
                    }
                  });
                }
              },
              child: ChatTile(
                isSender: !isReceiver,
                imageUrl: isReceiver ? data["senderImage"] : data['receiverImage'],
                name: isReceiver ? data["senderName"] : data["receiverName"],
                message: data["lastMessage"],
                time: timeField,
              ),
            );
          },
        );
      },
    );
  }
}
