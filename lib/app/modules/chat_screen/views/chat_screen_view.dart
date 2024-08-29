import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sunwise_project/themes.dart';

import '../controllers/chat_screen_controller.dart';
import '../widget/chat_bubble.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ChatScreenController());
    final scrollController = ScrollController();

    void scrollToBottom() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sunwise Bot', style: regulerText25),
            Obx(() => controller.isLoading.value
                ? Text('typing...', style: regulerText14)
                : Text("online", style: regulerText14)),
          ],
        ),
        backgroundColor: whiteColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                scrollToBottom();
                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.all(8.0),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    var message = controller.messages[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (message['user']!.isNotEmpty)
                          ChatBubble(message: message['user']!, isUser: true),
                        if (message['bot']!.isNotEmpty)
                          ChatBubble(message: message['bot']!, isUser: false),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      iconColor: accentColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: blackColor), // Default border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: accentColor,
                            width: 2.0), // Color when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: blackColor,
                            width: 1.0), // Color when enabled
                      ),
                    ),
                    onSubmitted: (value) {
                      var message = controller.messageController.text.trim();
                      if (message.isNotEmpty) {
                        controller.sendMessage(message);
                        controller.messageController.clear();
                        FocusScope.of(context).unfocus(); // Close the keyboard
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.circleChevronRight,
                      size: 45, color: accentColor),
                  onPressed: () {
                    var message = controller.messageController.text.trim();
                    if (message.isNotEmpty) {
                      controller.sendMessage(message);
                      controller.messageController.clear();
                      FocusScope.of(context).unfocus(); // Close the keyboard
                    }
                  },
                ),
              ],
            ),
          ),
          // Obx(
          //   () => controller.isLoading.value
          //       ? Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: CircularProgressIndicator(),
          //         )
          //       : Container(),
          // ),
        ],
      ),
    );
  }
}
