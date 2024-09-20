

import 'package:demo/search/controller/binding.dart';
import 'package:demo/search/view.dart';
import 'package:demo/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'chat/controller/binding.dart';
import 'chat/home.dart';


class AppPaths{
  static const initial = '/initial';
  static const search = '/search';
  static const chat = '/chat';


  static final routes = [
    GetPage(name: initial, page: () => const SplashPage()),
    GetPage(
      name: search,
      page: () =>  SearchPage(),
      binding: SearchBinding()
    ),
    GetPage(
        name: chat,
        page: () =>  ChatHome(),
        binding: HomeBinding()
    ),
  ];
}