import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import 'bean/message_bean.dart';
import 'controller/conversation_logic.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  final _formKey = GlobalKey<FormState>(); // 定义一个 GlobalKey
  final _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: GetX<ConversationLogic>(
              builder: (logic) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToNewMessage();
                });
                if (logic.currentMessageList.isNotEmpty) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: logic.currentMessageList.length,
                    itemBuilder: (context, index) {
                      var chat = logic.currentMessageList[index];


                      return _buildMessageCard(chat);
                    },
                  );
                } else {
                  return const Center(
                    child: Center(child: Text(
                      "请开启聊天吧...", style: TextStyle(color: Colors
                        .white70),)),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          GetBuilder<ConversationLogic>(builder: (logic) {
            return Form(
              key: _formKey, // 将 GlobalKey 赋值给 Form 组件的 key 属性
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: _handleKeyEvent,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13),
                        controller: logic.controller,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          // labelText: "请输入。。。",
                          hintText: "请输入",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          _sendMessage();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8))),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.send),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }


  Widget _buildMessageCard(MessageBean message) {
    var logic = Get.find<ConversationLogic>();

    if (message.from != logic.currentConversation.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'image_tmp.png',
                height: 30,
                width: 30,
              ).circular(15),
              const SizedBox(
                width: 5,
              ),
              const Text("我", style: TextStyle(color: Colors.white70),),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        message.content,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                'image_tmp.png',
                height: 30,
                width: 30,
              ).circular(15),
              const SizedBox(
                width: 5,
              ),
              Text(
                message.sender, style: const TextStyle(color: Colors.white70),),
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Card(
                    // color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        message.content,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: Card(
          //         elevation: 8,
          //         margin: const EdgeInsets.all(8),
          //         child: Text( message.content),
          //         // child: Markdown(text: message.text),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      );
    }
  }

  void _sendMessage() {
    var logic = Get.find<ConversationLogic>();
    logic.sendMessage(logic.controller.text);
    logic.controller.clear();
  }


  void _handleKeyEvent(RawKeyEvent value) {
    if (value.isKeyPressed(LogicalKeyboardKey.enter)) {
      // _sendMessage();
    }
  }

  void _scrollToNewMessage() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
