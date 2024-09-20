import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../search/bean/Patient.dart';
import '../bean/Conversation_user_bean.dart';
import '../controller/conversation_logic.dart';

class ItemConversation extends StatelessWidget {
  const ItemConversation({super.key, required this.conversation});

  final ConversationUserBean conversation;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationLogic>(builder: (logic) {
      return Card(
        elevation: 1,
        color: Colors.grey.withAlpha(60),
        child: ListTile(

          onTap: () {
            logic.selectConversation(conversation.name);
            // _tapConversation(index);
          },
          selected: logic.currentConversation.value ==
              conversation.name,
          leading: Image.asset(
            'image_tmp.png',
            height: 30,
            width: 30,
          ).circular(15),
          title: Text(
            conversation.name,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.white),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0条消息',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(80)),
              ),

              Text(
                '2024-09-20',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(80)),
              ),
            ],
          ),

        ),
      );
    });
  }
}
