import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life/classes/model/species.dart';

import '../../classes/base_net_work.dart';
import '../../classes/result/result.dart';
import '../../icons/other_icons.dart';
import '../../widgets/biology_card.dart';

class BiologyPageWidget extends StatefulWidget {
  final Map? arguments;

  const BiologyPageWidget({Key? key, this.arguments}) : super(key: key);

  @override
  State<BiologyPageWidget> createState() => _BiologyPageWidgetState();
}

class _BiologyPageWidgetState extends State<BiologyPageWidget> {
  late int _current = 1;

  late int maxPage = 1;

  List<BiologyArticle> allArticles = [];

  ScrollController controller = ScrollController();

  late StreamController<List<BiologyArticle>> articleController =
      StreamController();

  late Sink<List<BiologyArticle>> articleSink = articleController.sink;

  late Stream<List<BiologyArticle>> articleStream = articleController.stream;

  @override
  void initState() {
    super.initState();
    _current = 1;
    refreshGridView();
    articleStream.listen((event) {
      setState(() {
        allArticles.addAll(event);
      });
    });

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        appendGridView();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    articleController.close();
  }

  @override
  Widget build(BuildContext context) {
    late Species species;
    var arguments = ModalRoute.of(context)?.settings.arguments as Map;
    species = arguments['species'];

    final double width = MediaQuery.of(context).size.width;
    final double rowWidth = width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          species.speciesName,
        ),
        elevation: 0.0,
        leading: const Icon(OtherIcons.call),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshGridView,
          child: GridView.builder(
            itemCount: allArticles.length,
            shrinkWrap: true,
            controller: controller,
            padding: const EdgeInsets.all(8.0),
            physics: const AlwaysScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 5 / 6,
              maxCrossAxisExtent: 180.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return BiologyCardWidget(
                  rowWidth: rowWidth, article: allArticles[index]);
            },
          ),
        ),
      ),
    );
  }

  Future<void> refreshGridView() async {
    if (kDebugMode) {
      print('下拉刷新');
    }
    _current = 1;
    allArticles.clear();
    acquireArticleStream().map((event) {
      articleSink.add(event);
    }).first;
  }

  Future<void> appendGridView() async {
    if (kDebugMode) {
      print('上拉加载更多');
    }
    _current++;

    if (_current > maxPage) {
      _current = maxPage;
      return;
    }

    acquireArticleStream().map((event) {
      articleSink.add(event);
    }).first;
  }

  Stream<List<BiologyArticle>> acquireArticleStream() {
    return ApiService()
        .post<String>('/article/find/page',
            params: {"size": 8, "current": _current, "paramer": {}})
        .map((event) => PageResults.fromJson(event))
        .map((event) => PageResults(
              current: event.current,
              size: event.size,
              total: event.total,
              code: event.code,
              message: event.message,
              success: event.success,
              timestamp: event.timestamp,
              data: event.data.map((e) {
                BiologyArticle asd = BiologyArticle.fromJson(e);
                return asd;
              }).toList(),
            ))
        .map((event) {
          maxPage = event.total;
          return event;
        })
        .map((event) => event.data);
  }
}
