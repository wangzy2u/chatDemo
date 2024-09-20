import 'dart:convert';

import 'package:demo/base/utils/date_util.dart';
import 'package:demo/base/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../search/bean/Patient.dart';
import '../bean/Conversation_user_bean.dart';
import '../bean/message_bean.dart';
import '../item/start_chat_dialog.dart';

class ConversationLogic extends GetxController {
  //对话列表
  final conversationList = <ConversationUserBean>[].obs;
  final patientList = <Patient>[].obs;

  //当前聊天
  final currentConversation = "".obs;

  final controller = TextEditingController();

  //消息列表
  final currentMessageList = <MessageBean>[].obs;
  final allMessageList = <MessageBean>[].obs;

  @override
  void onReady() {
    super.onReady();

    loadPatients();
    loadConversationList();
  }

  void loadPatients() {
    rootBundle.loadString('/patients.json').then((value) {
      if (value.isNotEmpty) {
        List result = json.decode(value);
        patientList.addAll(result.map((m) => Patient.fromJson(m)).toList());
      }
    });
  }

  Future<void> loadConversationList() async {
    final saveConversation = SpUtil.getString('conversationList') ?? '';

    print('读取聊天列表$saveConversation');

    if (saveConversation.isNotEmpty) {
      conversationList.clear();
      final List result = json.decode(saveConversation);
      conversationList
          .addAll(result.map((m) => ConversationUserBean.fromJson(m)).toList());
    }
  }

  //选择聊天
  void selectConversation(String select) {
    controller.clear();
    if (conversationList.isNotEmpty) {
      currentConversation.value = select;
      loadMessages();
    }
  }

  //加载消息
  Future<void> loadMessages() async {
    currentMessageList.clear();
    final savedMessages = SpUtil.getString('messages') ?? '';
    print('聊天内容${savedMessages}');
    final List result = json.decode(savedMessages);

    List<MessageBean> filteredPeople =
        result.map((m) => MessageBean.fromJson(m)).toList();

    allMessageList.clear();
    allMessageList.addAll(filteredPeople);

    currentMessageList.addAll(allMessageList
        .where((person) => person.sender == currentConversation.value)
        .toList());
  }

  //保存消息
  Future<void> saveMessage(String sender, String from, String content) async {
    String timestamp = DateUtil.getNowDateStr();
    allMessageList.add(MessageBean(
        sender: sender, from: from, content: content, timestamp: timestamp));
    currentMessageList.add(MessageBean(
        sender: sender, from: from, content: content, timestamp: timestamp));
    final savedMessages = json.encode(allMessageList);
    await SpUtil.putString('messages', savedMessages);
  }

  //开启聊天
  void addChat() async {
    Patient result = await Get.dialog(StartChatDialog(
      indexList: patientList,
    ));

    if (result != null) {
      // 使用 any 方法根据 name 字段判断对象是否存在
      bool exists =
          conversationList.any((person) => person.name == result.name);

      if (exists) {
        //聊天已存在
      } else {
        //加入列表
        conversationList
            .add(ConversationUserBean(name: result.name, avatar: ''));
        //保存聊天
        final savedMessages = json.encode(conversationList);
        await SpUtil.putString('conversationList', savedMessages);
      }

      selectConversation(result.name);
      loadConversationList();
    }
  }

  void sendMessage(String text) {
    if (text.isNotEmpty && currentConversation.isNotEmpty) {
      saveMessage(currentConversation.value, '我', text);
      // Simulate receiving a message
      saveMessage(
          currentConversation.value, currentConversation.value, '收到: $text');
    }
  }
}
