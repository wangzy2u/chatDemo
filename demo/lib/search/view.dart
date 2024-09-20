import 'package:demo/base/extension/widget.dart';
import 'package:demo/search/item/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/logic.dart';
import 'item/item_patient.dart';

class SearchPage extends StatelessWidget {
  final logic = Get.find<SearchLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          InkWell(
            onTap: () async {
              FilterResult result = await Get.dialog(FilterDialog(
                index: logic.index,
                selectedGender: logic.selectedGender,
              ));

              logic.startFilter(result);

              // _showFilterDialog(context);
            },
            child: const Text('筛选').padding(right: 20),
          )
        ],
        title: const Text('HomeGroup'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withAlpha(80),
            ),
            child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: logic.searchController,
                      // autofocus: true,
                      // focusNode: accountFn,
                      textInputAction: TextInputAction.search,

                      keyboardType: TextInputType.text,

                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                        // contentPadding:
                        //     EdgeInsets.symmetric(vertical: -10, horizontal: -10),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                        counterText: "",
                      ),

                      onChanged: (String str) {},
                      onSubmitted: (String str) {
                        logic.search(str);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withAlpha(80),
            ),
            child: const Row(
              children: [
                Icon(Icons.add),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Invite Member',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<SearchLogic>(builder: (logic) {
              return ListView.builder(
                  itemCount: logic.filteredPatients.length,
                  itemBuilder: (c, i) {
                    return ItemPatient(
                      patient: logic.filteredPatients[i],
                    );
                  });
            }),
          ),
          Text(logic.title).circular(8)
        ],
      ),
    );
  }
}
