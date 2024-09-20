import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

import 'chat_view.dart';
import 'conversation_list_view.dart';

class ChatHome extends GetResponsiveView{
  ChatHome({super.key});


  @override
  Widget? phone() {
    return Scaffold(
      appBar: AppBar(
        title: Text('appTitle'),
      ),
      drawer: const ConversationListView(),
      // body: const ChatWindow(),
    );
  }

  @override
  Widget? desktop() {
    return const Scaffold(
      body: Row(
        children: [
          ConversationListView(),
          Expanded(child: ChatView()),
        ],
      ),
    );
  }

  @override
  Widget? builder() {
    return super.builder();
  }
}