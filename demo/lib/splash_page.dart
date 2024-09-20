import 'package:demo/base/extension/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'app_paths.dart';
import 'base/utils/sp_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SpUtil.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Get.toNamed(AppPaths.search);
            },
            child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.black12,
                    child: const Text('searth'))
                .circular(5),
          ).center(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (){
              Get.toNamed(AppPaths.chat);
            },
            child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.black12,
                    child: const Text('chat'))
                .circular(5),
          ).center()
        ],
      ),
    );
  }
}
