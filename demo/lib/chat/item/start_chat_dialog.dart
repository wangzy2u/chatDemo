import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../search/bean/Patient.dart';

class StartChatDialog extends StatefulWidget {
  StartChatDialog({super.key, required this.indexList});


  final List<Patient> indexList;

  @override
  State<StartChatDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<StartChatDialog> {


  List<Patient> indexList = [];



  @override
  void initState() {
    super.initState();
    indexList =  widget.indexList;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        color: Colors.white,

        child: ListView.builder(
            itemCount: indexList.length,
            itemBuilder: (context,index){

          return ListTile(

            onTap: () {
              Get.back(result: indexList[index]);
            },
            leading: Image.asset(
              'image_tmp.png',
              height: 30,
              width: 30,
            ).circular(15),
            title: Text(
              indexList[index].name,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black),
            ),
            subtitle: Text(
              '${indexList[index].gender} ${indexList[index].age}岁',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withAlpha(80)),
            ),

          );
        }),
      ).circular(12).margin(EdgeInsets.all(15)).center(),
    );
  }
}



class FilterResult{

  String ? selectedGender;
  int ? index;

  FilterResult(this.selectedGender, this.index);
}


class IndexBean{
  final int  index;
  bool  select;

  IndexBean(this.index, this.select);
}