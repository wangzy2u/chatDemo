import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../bean/Patient.dart';
import '../item/filter_dialog.dart';

class SearchLogic extends GetxController {


  String title = 'titlessss';


  final searchController = TextEditingController();


  final List<Patient> _patients = [
    Patient(name: "李一",adress: '上海市',gender: '女',age: 26,step: 1,maxStep: 12,state: '进展一般',visible: false,identity: false),
    Patient(name: "王二",adress: '广州市',gender: '男',age: 36,step: 2,maxStep: 12,state: '恢复中',visible: false,identity: false),
    Patient(name: "赵三",adress: '深圳市',gender: '女',age: 40,step: 1,maxStep: 12,state: '进展一般',visible: false,identity: false),
    Patient(name: "钱四",adress: '成都市',gender: '女',age: 29,step: 3,maxStep: 12,state: '进展一般',visible: false,identity: true),
    Patient(name: "孙五",adress: '杭州市',gender: '男',age: 31,step: 6,maxStep: 12,state: '进展一般',visible: true,identity: true),
    Patient(name: "周六",adress: '南京市',gender: '女',age: 26,step: 1,maxStep: 12,state: '进展一般',visible: false,identity: false),
    Patient(name: "吴七",adress: '天津市',gender: '男',age: 44,step: 1,maxStep: 12,state: '恢复中',visible: false,identity: false),
    Patient(name: "郑八",adress: '武汉市',gender: '男',age: 50,step: 8,maxStep: 12,state: '良好',visible: true,identity: true),
    Patient(name: "冯九",adress: '西安市',gender: '男',age: 20,step: 1,maxStep: 12,state: '进展一般',visible: false,identity: false),
    Patient(name: "谢石",adress: '北京市',gender: '女',age: 17,step: 9,maxStep: 12,state: '良好',visible: true,identity: true),

  ];


  List<Patient> filteredPatients = [];
  String searchQuery = '';
  String? selectedGender;
  int index = -1;


  void search(String str){
    searchQuery = str;
     _filterPatients();
    update();
  }




  @override
  void onReady() {
    super.onReady();




    // String j = json.encode(_patients);






    loadPatients();
  }


  void loadPatients(){
    rootBundle.loadString('/patients.json').then((value){

      if(value.isNotEmpty){
        List result = json.decode(value);

        _patients.addAll(result.map((m)=> Patient.fromJson(m)).toList());


        filteredPatients = _patients;
        update();
      }



    });
  }


  void startFilter(FilterResult ? filter){
    if(filter == null){
      selectedGender = null;
      index = -1;

    }else{
      selectedGender = filter.selectedGender;
      index = filter.index ?? -1;
    }

    _filterPatients();
    update();
  }



  void _filterPatients() {
      filteredPatients = _patients.where((patient) {
        bool matchesSearch = patient.name.contains(searchQuery);
        bool matchesGender = selectedGender == null || patient.gender == selectedGender;
        bool matchesIdentity = index == -1 || patient.step == index;
        return matchesSearch && matchesGender && matchesIdentity;
      }).toList();
  }



}
