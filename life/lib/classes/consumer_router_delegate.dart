import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life/pages/biology/biology_page.dart';

import '../pages/biology/biology_detail_page.dart';
import '../pages/blank_page.dart';
import '../pages/commons/menus_page.dart';
import '../pages/homepage/home.dart';
import '../pages/menus/consumer_android.dart';
import '../pages/menus/consumer_biology.dart';
import '../pages/menus/consumer_blockchain.dart';
import '../pages/menus/consumer_html5.dart';
import '../pages/menus/consumer_ios.dart';
import '../pages/menus/consumer_java.dart';
import '../pages/menus/consumer_python.dart';
import '../pages/menus/consumer_win.dart';
import '../pages/tools/consumer_account.dart';
import '../pages/tools/consumer_scan.dart';
import '../pages/tools/consumer_setting.dart';
import '../pages/tools/qr_code.dart';

class Delegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final List<Page> _pages = [];

  static final Delegate _instance =
      Delegate._internal();

  Delegate._internal() {
    if (kDebugMode) {
      print('init');
    }
    if (_pages.isEmpty) {
      push(name: '/');
    }
  }

  factory Delegate() {
    return _instance;
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }

  @override
  List<Page> get currentConfiguration => List.of(_pages);

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    debugPrint('setNewRoutePath ${configuration.last.name}');

    _setPath(configuration
        .map((routeSettings) => _createPage(routeSettings))
        .toList());
    return Future.value(null);
  }

  void _setPath(List<Page> pages) {
    _pages.clear();
    _pages.addAll(pages);
    notifyListeners();
  }

  @override
  Future<bool> popRoute() {
    if (kDebugMode) {
      print('${_pages.length}');
    }
    if (canPop()) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmExit();
  }

  bool canPop() {
    return _pages.length > 1;
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;

    if (canPop()) {
      _pages.removeLast();
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> push({required String name, dynamic arguments}) async {
    CustomPage page = _createPage(RouteSettings(
      name: name,
      arguments: arguments,
    ));
    _pages.add(page);
    notifyListeners();
    return await page.result.future;
  }

  Future<dynamic> replace({required String name, dynamic arguments}) async {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    return push(name: name, arguments: arguments);
  }

  CustomPage _createPage(RouteSettings routeSettings) {
    Widget child;
    switch (routeSettings.name) {
      case '/':
        child = const Home();
        break;
      case '/java':
        child = const JavaWidget();
        break;
      case '/python':
        child = const PythonWidget();
        break;
      case '/android':
        child = const AndroidWidget();
        break;
      case '/account':
        child = const AccountWidget();
        break;
      case '/setting':
        child = const SettingWidget();
        break;
      case '/win':
        child = const WinWidget();
        break;
      case '/html5':
        child = const Html5Widget();
        break;
      case '/ios':
        child = const IosWidget();
        break;
      case '/blockchain':
        child = const BlockchainWidget();
        break;
      case '/qrcode':
        child = const QrcodeWidget();
        break;
      case '/scan':
        child = const ScanWidget();
        break;
      case '/biology':
        child = const BiologyWidget();
        break;
      case '/biology/page':
        child = const BiologyPageWidget();
        break;
      case '/article/detail/page':
        child = BiologyDetailPageWidget(arguments: routeSettings.arguments as Map,);
        break;
      default:
        child = const BlankPageWidget();
    }
    return CustomPage(
      child: child,
      key: Key(routeSettings.name!) as LocalKey,
      name: routeSettings.name,
      arguments: routeSettings.arguments,
      fullscreenDialog: false,
    );
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: const Text(
              '确定要退出App吗?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.grey),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                  elevation: MaterialStateProperty.all(0.0),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                  minimumSize: MaterialStateProperty.all(const Size(78, 35)),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    const StadiumBorder(),
                  ),
                ),
                child: const Text(
                  '取消',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.focused) &&
                        !states.contains(MaterialState.pressed)) {
                      return Colors.blue;
                    } else if (states.contains(MaterialState.pressed)) {
                      return Colors.deepPurple;
                    }
                    return Colors.grey;
                  }),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue[200];
                    }
                    return Colors.blue;
                  }),
                  overlayColor: MaterialStateProperty.all(Colors.blueAccent),
                  elevation: MaterialStateProperty.all(0.0),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                  minimumSize: MaterialStateProperty.all(const Size(78, 35)),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    const StadiumBorder(),
                  ),
                ),
                child: const Text(
                  '确定',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          );
        });
    return result ?? true;
  }
}
