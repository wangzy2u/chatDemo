

import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bean/Patient.dart';

class ItemPatient extends StatelessWidget {
  const ItemPatient({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 15),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withAlpha(50),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15,),
          Image.asset(patient.avatar??'image_tmp.png',height: 45,width: 45,).circular(22.5),
          const SizedBox(width: 15,),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(patient.name ,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),

                  const SizedBox(width: 8,),
                  Text('(${patient.gender ?? '女'})',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                  const SizedBox(width: 4,),
                  Text('${patient.age ?? '0'}岁',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

                  const SizedBox(width: 4,),
                  Text('|',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                  const SizedBox(width: 4,),
                  Text(patient.identity ?'会员':'非会员',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                ],
              ),

              Text('地址：${patient.adress}',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),
              Text('治疗周期：${patient.step}-总疗程：${patient.maxStep}',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),
              Text('治疗进度：${patient.state}',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12)),

            ],
          )
        ],
      ),
    );
  }
}
