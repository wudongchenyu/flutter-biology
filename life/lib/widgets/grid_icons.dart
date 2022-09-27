import 'package:flutter/material.dart';

import '../icons/all_icons.dart';
import '../icons/other_icons.dart';

class GridIcons {
  static List<IconData> iconList = List.of(routers.keys);

  static Map<IconData, String> routers = {
    OtherIcons.java:'/java',
    OtherIcons.python:'/python',
    AllIcons.android:'/android',
    AllIcons.html5:'/html5',
    AllIcons.database:'/database',
    OtherIcons.cloud:'/cloud',
    AllIcons.chain:'/blockchain',
    OtherIcons.app_store_ios:'/ios',
    AllIcons.win8:'/win',
    OtherIcons.dna:'/biology',
  };

  static String getRouter(IconData index) {
    return routers[index] ?? '/';
  }

}