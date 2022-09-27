import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'classes/consumer_route_information_parser.dart';
import 'classes/consumer_router_delegate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // 竖屏 Portrait 模式
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'LIFE',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routerDelegate: CustomRouter(),
      routeInformationParser: const ConsumerRouteInformationParser(),
      // initialRoute: "/",
      // routes: {
      //   '/':(context) => const Home(),
      //   '/java':(context) => const Home(),
      //   '/flutter':(context) => const Home(),
      //   '/dart':(context) => const Home(),
      //   '/block/chain':(context) => const Home(),
      //   '/reactor':(context) => const Home(),
      //   '/camunda':(context) => const Home(),
      // },
    );
  }
}

