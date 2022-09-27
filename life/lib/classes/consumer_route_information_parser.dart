import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConsumerRouteInformationParser
    extends RouteInformationParser<List<RouteSettings>> {
  const ConsumerRouteInformationParser() : super();

  @override
  Future<List<RouteSettings>> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return Future.value([const RouteSettings(name: '/')]);
    }

    final routeSettings = uri.pathSegments
        .map((pathSegment) => RouteSettings(
              name: '/$pathSegment',
              arguments: pathSegment == uri.pathSegments.last
                  ? uri.queryParameters
                  : null,
            ))
        .toList();

    return Future.value(routeSettings);
  }

  @override
  RouteInformation restoreRouteInformation(List<RouteSettings> configuration) {
    final location = configuration.last.name;
    final arguments = _restoreArguments(configuration.last);

    return RouteInformation(location: '$location$arguments');
  }

  String _restoreArguments(RouteSettings routeSettings) {

    if (null == routeSettings.arguments) {
      return '';
    }

    if (kDebugMode) {
      print(routeSettings.toString());
    }

    var args = routeSettings.arguments as Map;
    // if (routeSettings.name == '/biology/page') {
    //   return '?type=${args['type']}';
    // }

    if (routeSettings.name != '/details') return '';

    return '?name=${args['name']}&imgUrl=${args['imgUrl']}';
  }
}
