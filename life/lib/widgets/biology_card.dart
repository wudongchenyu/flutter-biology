import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import '../classes/consumer_router_delegate.dart';
import '../classes/model/species.dart';

class BiologyCardWidget extends StatefulWidget {
  const BiologyCardWidget(
      {Key? key, required this.rowWidth, required this.article})
      : super(key: key);
  final double rowWidth;
  final BiologyArticle? article;
  @override
  State<BiologyCardWidget> createState() => _BiologyCardWidgetState();
}

class _BiologyCardWidgetState extends State<BiologyCardWidget> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.article);
    }
    return Container(
      height: 240.0,
      width: widget.rowWidth,
      padding: const EdgeInsets.all(
        5.0,
      ),
      child: Card(
        color: Colors.black12,
        borderOnForeground: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InkWell(
              onTap: () {
                if (kDebugMode) {
                  print('点击了图片:${widget.article?.code}');
                }
                Delegate().push(name: '/article/detail/page', arguments: {
                  'article': widget.article,
                });
              },
              child: Image.asset(
                widget.article?.articleIcons ?? 'asserts/images/b2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 5.0,
              left: 5.0,
              child: CircleAvatar(
                radius: 18.0,
                backgroundImage: AssetImage(
                    widget.article?.articleIcons ?? 'asserts/images/b3.jpeg'),
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 5.0,
              child: Text(
                '￥${widget.article?.salePrice.toString()}',
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              left: -32.0,
              width: 120.0,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: acquireSale(widget.article?.salesStatus),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String acquireStatus(int? salesStatus) {
    String result;
    switch (widget.article?.salesStatus) {
      case 0:
        result = '销售中';
        break;
      case 1:
        result = '已售罄';
        break;
      case 2:
        result = '已停售';
        break;
      case 3:
        result = '待发售';
        break;
      default:
        result = '待发售';
        break;
    }
    return result;
  }

  Widget acquireSale(int? salesStatus) {
    if (salesStatus == 0) {
      return Container(
        width: 120.0,
        color: Colors.lightGreenAccent,
        padding: const EdgeInsets.only(left: 30.0),
        child: const Text(
          '销售中',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (salesStatus == 1) {
      return Container(
        width: 120.0,
        color: Colors.red,
        padding: const EdgeInsets.only(left: 30.0),
        child: const Text(
          '已售罄',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (salesStatus == 2) {
      return Container(
        width: 120.0,
        color: Colors.red,
        padding: const EdgeInsets.only(left: 30.0),
        child: const Text(
          '已停售',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    if (salesStatus == 3) {
      return Container(
        width: 120.0,
        color: Colors.grey,
        padding: const EdgeInsets.only(left: 30.0),
        child: const Text(
          '待发售',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return const Text(
      '待发售',
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.black26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
