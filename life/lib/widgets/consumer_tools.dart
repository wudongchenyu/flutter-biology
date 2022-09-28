import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../classes/consumer_router_delegate.dart';
import '../classes/tools_item.dart';

class ToolsWidget extends StatefulWidget {
  const ToolsWidget({Key? key}) : super(key: key);

  @override
  State<ToolsWidget> createState() => _ToolsWidgetState();
}

class _ToolsWidgetState extends State<ToolsWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.black87,
      constraints: const BoxConstraints(
        minWidth: 2.0 * 45.0,
        maxWidth: 5.0 * 45.0,
      ),
      itemBuilder: (BuildContext context) {
        return ToolsItem.menus.map((ToolsItem item) {
          return PopupMenuItem(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.icon.icon,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Text(
                  item.title,
                  style: const TextStyle(color: Colors.white,),
                ),
              ],
            ),
          );
        }).toList();
      },
      onSelected: (ToolsItem action) {
        if (kDebugMode) {
          print(action.icon);
        }
        Delegate().push(
          name: action.value,
        );
      },
    );
  }
}
