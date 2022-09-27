import 'package:flutter/material.dart';

class ToolsItem {
  final String title;
  final Icon icon;
  final String value;

  ToolsItem({required this.title, required this.value, required this.icon});

  static final List<ToolsItem> menus = [
    ToolsItem(title: '个人信息', value: '/account', icon: const Icon(Icons.account_circle_sharp),),
    ToolsItem(title: '扫一扫', value: '/scan', icon: const Icon(Icons.crop_free_outlined),),
    ToolsItem(title: '二维码', value: '/qrcode', icon: const Icon(Icons.qr_code_2),),
    ToolsItem(title: '设置', value: '/setting', icon: const Icon(Icons.settings),),
  ];
}