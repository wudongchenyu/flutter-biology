import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../classes/base_net_work.dart';
import '../../classes/model/species.dart';
import '../../classes/result/result.dart';

class BiologyDetailPageWidget extends StatefulWidget {
  final Map? arguments;

  const BiologyDetailPageWidget({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  State<BiologyDetailPageWidget> createState() =>
      _BiologyDetailPageWidgetState();
}

class _BiologyDetailPageWidgetState extends State<BiologyDetailPageWidget> {
  StreamController<String> streamController = StreamController();

  late BiologyArticle article;

  late int currentTimerNumber;

  late DateTime expireTime;

  late String remainTime;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    var newArguments = widget.arguments as Map;
    article = newArguments['article'];
    expireTime = article.saleTime!;
    remainTime = acquireTimeString();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.articleName,
        ),
        elevation: 0.0,
        leading: CircleAvatar(
          radius: 10.0,
          backgroundImage: AssetImage(article.articleIcons),
        ),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(
                    height: 360.0,
                    image: AssetImage(article.articleIcons),
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        article.articleName,
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 200.0,
                        ),
                        child: Text(
                          article.intro,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24.0,
                        backgroundImage: AssetImage(article.articleIcons),
                      ),
                      const SizedBox(
                        width: 26.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                article.author,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                article.author,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black54,
        notchMargin: 8.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Icon(
              Icons.share,
              size: 24.0,
              color: Colors.white,
            ),
            Text(
              '￥${article.salePrice}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            buildButton(article.salesStatus),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    ApiService()
        .get<String>('/article/find/detail', params: {"code": article.code})
        .map((event) => Result.fromJson(event))
        .map((event) => Result(
              code: event.code,
              message: event.message,
              success: event.success,
              timestamp: event.timestamp,
              data: BiologyArticle.fromJson(event.data),
            ))
        .listen((event) {
          setState(() {
            article = event.data!;
          });
        });
  }

  void startTimer() {
    var t = DateTime.now();
    var s = expireTime;
    currentTimerNumber = s.difference(t).inSeconds;

    if (kDebugMode) {
      print('currentTimerNumber:$currentTimerNumber');
    }

    const repeatPeriod = Duration(seconds: 1);
    _timer = Timer.periodic(
      repeatPeriod,
      (timer) {
        currentTimerNumber--;
        if (currentTimerNumber <= 0) {
          _timer.cancel();
          currentTimerNumber = 0;
        }
        //外面传进来的单位是秒，所以需要根据总秒数，计算小时，分钟，秒
        int hour = (currentTimerNumber ~/ 3600) % 24;
        int minute = currentTimerNumber % 3600 ~/ 60;
        int second = currentTimerNumber % 60;

        var str = '';
        if (hour > 0) {
          str = '$str$hour:';
        }

        if (minute / 10 < 1) {
          //当只有个位数时，给前面加“0”，实现效果：“:01”,":02"
          str = '${str}0${minute.toString()}:';
        } else {
          str = "$str$minute:";
        }

        if (second / 10 < 1) {
          str = '${str}0$second';
        } else {
          str = str + second.toString();
        }

        setState(() {
          if (str == '00:00') {
            str = '';
          }
          remainTime = str;
        });

        streamController.add(remainTime);
      },
    );
  }

  String acquireTimeString() {
    var t = DateTime.now();
    var s = expireTime;
    int timerNumber = s.difference(t).inSeconds;

    if (kDebugMode) {
      print('timerNumber:$timerNumber');
    }
    //外面传进来的单位是秒，所以需要根据总秒数，计算小时，分钟，秒
    int hour = (timerNumber ~/ 3600) % 24;
    int minute = timerNumber % 3600 ~/ 60;
    int second = timerNumber % 60;

    var str = '';
    if (hour > 0) {
      str = '$str$hour:';
    }

    if (minute / 10 < 1) {
      //当只有个位数时，给前面加“0”，实现效果：“:01”,":02"
      str = '${str}0${minute.toString()}:';
    } else {
      str = "$str$minute:";
    }

    if (second / 10 < 1) {
      str = '${str}0$second';
    } else {
      str = str + second.toString();
    }
    return str;
  }

  Widget buildButton(int salesStatus) {
    if (article.salesStatus == 3) {
      return StreamBuilder<String>(
        stream: streamController.stream,
        initialData: remainTime,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          String nowTime = snapshot.data ?? '';
          return TextButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: nowTime == ''
                  ? MaterialStateProperty.all(Colors.greenAccent[700])
                  : MaterialStateProperty.all(Colors.grey),
              minimumSize: MaterialStateProperty.all(const Size(180.0, 36.0)),
              shape: MaterialStateProperty.all(const StadiumBorder()),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (nowTime != '') {
                  return Colors.grey;
                }

                if (states.contains(MaterialState.pressed)) {
                  return Colors.lightGreenAccent[400];
                }
                return Colors.green;
              }),
            ),
            child: Text(
              nowTime == '' ? '立即购买' : nowTime,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          );
        },
      );
    }

    if (article.salesStatus == 0) {
      return acquireButton('立即购买');
    }

    if (article.salesStatus == 1 || article.salesStatus == 2) {
      return acquireButton('去市场看看');
    }
    return acquireButton('去市场看看');
  }

  Widget acquireButton(String message) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.greenAccent),
        minimumSize: MaterialStateProperty.all(const Size(180.0, 36.0)),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.lightGreenAccent[400];
          }
          return Colors.green;
        }),
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
