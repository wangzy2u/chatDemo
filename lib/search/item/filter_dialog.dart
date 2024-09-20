import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDialog extends StatefulWidget {
  FilterDialog({super.key, this.selectedGender, required this.index});


  final String ? selectedGender;
  final int  index;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {


  String ? selectedGender;
  int  _selectedCycle = -1 ;


  List<IndexBean> indexList = [];



  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
    _selectedCycle = widget.index;


    indexList =  List.generate(12, (i){
      return IndexBean(i, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(

        color: Colors.white,

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  hint: Text('选择性别'),
                  value: selectedGender,
                  items: ['男', '女'].map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      // _filterPatients();
                    });
                  },
                ),
                DropdownButton<int>(
                  hint: Text('选择疗程'),
                  value: _selectedCycle > 0 ? _selectedCycle : null,
                  items: List.generate(12, (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text('第${index + 1}疗程'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCycle = value!;
                      // _filterPatients();
                    });
                  },
                ),
              ],
            ),

            Container(
              height: 1,
              color: Colors.grey.withAlpha(50),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      selectedGender = null;
                      _selectedCycle = -1;
                      FilterResult result = FilterResult(selectedGender,_selectedCycle);
                      Get.back(result: result);
                    },
                    child: SizedBox(
                      height: 50,
                      child: Text('重置',).center(),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: Colors.grey.withAlpha(50),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      FilterResult result = FilterResult(selectedGender,_selectedCycle!);
                      Get.back(result: result);
                    },
                    child: SizedBox(
                      height: 50,
                      child: Text('确定').center(),
                    ),
                  ),
                )
                ,
              ],
            )
          ],
        ),
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