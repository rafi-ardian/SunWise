import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreenController extends GetxController {
  var messages = <Map<String, String>>[].obs;
  var isLoading = false.obs;
  var messageController = TextEditingController();

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    // Add user's message to the list
    messages.add({'user': message, 'bot': ''});
    isLoading.value = true;

    // var url = "https://chatbot-j5nhigjovq-uc.a.run.app/chatbot";
    var url = "https://chatbotbeneran-j5nhigjovq-uc.a.run.app/chatbot";

    try {
      var response =
          await http.post(Uri.parse(url), body: {'message': message});
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        // Update the last message with bot's response
        messages[messages.length - 1] = {
          'user': message,
          'bot': responseData['response']
        };
        messages.refresh(); // Refresh the messages list
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
