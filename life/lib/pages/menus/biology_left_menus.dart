import 'package:flutter/material.dart';

import 'menu_left_title.dart';

class LeftDrawerWidget extends StatefulWidget {
  const LeftDrawerWidget({Key? key}) : super(key: key);

  @override
  State<LeftDrawerWidget> createState() => _LeftDrawerWidgetState();
}

class _LeftDrawerWidgetState extends State<LeftDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 228.0,
      backgroundColor: Colors.black54,
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(
              Icons.face,
              size: 48.0,
              color: Colors.white,
            ),
            accountName: Text('舞动晨雨'),
            accountEmail: Text('wudochyu@163.com'),
            otherAccountsPictures: <Widget>[
              Icon(
                Icons.bookmark_border,
                color: Colors.white,
              ),
            ],
            decoration:BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asserts/images/faceback.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          MenuListTitleWidget(),
        ],
      ),
    );
  }
}
