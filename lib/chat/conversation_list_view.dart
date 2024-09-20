import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'controller/conversation_logic.dart';
import 'item/item_conversation.dart';

class ConversationListView extends StatelessWidget {
  const ConversationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          color: Color(0xFF1E211E),
          border: Border(right: BorderSide(width: .1))),
      constraints: const BoxConstraints(maxWidth: 300),
      child: GetX<ConversationLogic>(builder: (logic) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logic.conversationList.isEmpty ? const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '暂无聊天',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
            :
            Expanded(
              child: ListView.builder(
                itemCount: logic.conversationList.length,
                itemBuilder: (context, index) {
                  return ItemConversation(conversation: logic.conversationList[index],);
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 35,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  color: Colors.grey.withAlpha(70),
                  child: const Text('设置',style: TextStyle(color: Colors.white)),
                ).circular(12),
                InkWell(
                  onTap: (){
                    logic.addChat();
                  },
                  child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    color: Colors.grey.withAlpha(70),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text('新对话',style: TextStyle(color: Colors.white)),
                  ).circular(12),
                )
              ],
            ).margin(const EdgeInsets.symmetric(horizontal: 16)),
            const SizedBox(height: 20,)
          ],
        );
      }),
    );
  }
}
