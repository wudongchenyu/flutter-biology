import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:decimal/decimal.dart';

@JsonSerializable(genericArgumentFactories: true)
class Species {
  String code;
  String speciesName;
  int level;
  bool enabled = true;
  String parent;
  String source;
  List<Species>? children;
  String? icon;

  Species({
    required this.code,
    required this.speciesName,
    required this.level,
    required this.parent,
    required this.source,
    this.children,
    required this.enabled,
    this.icon,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        code: json['code'],
        speciesName: json['speciesName'],
        level: json['level'],
        parent: json['parent'] ?? '',
        source: json['source'] ?? '',
        enabled: json['enabled'] ?? true,
        children: (json['children'] as List<dynamic>)
            .map((e) => Species.fromJson(e))
            .toList(),
        icon: json['icon'] ?? '',
      );
}

class BiologyArticle {
  late String code;
  late String articleName;
  late String articleIcons;
  late int articleType;
  late int affiliation;
  late String author;
  late String biologyCode;
  late String intro;
  late bool enabled;
  late int salesStatus;
  late Decimal discounts;
  late Decimal salePrice;
  late DateTime? saleTime;
  late DateTime? selloutTime;
  late DateTime? publishTime;

  BiologyArticle({
    required this.code,
    required this.articleName,
    required this.articleIcons,
    required this.articleType,
    required this.affiliation,
    required this.author,
    required this.biologyCode,
    required this.intro,
    required this.enabled,
    required this.salesStatus,
    required this.discounts,
    required this.salePrice,
    this.saleTime,
    this.selloutTime,
    this.publishTime,
  });

  factory BiologyArticle.fromJson(Map<String, dynamic> json) {
    BiologyArticle article = BiologyArticle(
      code: json['code'],
      articleName: json['articleName'],
      articleIcons: json['articleIcons'],
      articleType: json['articleType'],
      affiliation: json['affiliation'],
      author: json['author'],
      biologyCode: json['biologyCode'],
      intro: json['intro'],
      enabled: json['enabled'],
      salesStatus: json['salesStatus'],
      discounts: Decimal.parse(json['discounts'].toString()),
      salePrice: Decimal.parse(json['salePrice'].toString()),
      saleTime: json['saleTime'] == null ? null : DateTime.parse(json['saleTime']),
      selloutTime: json['selloutTime'] == null ? null : DateTime.parse(json['selloutTime']),
      publishTime: json['publishTime'] == null ? null : DateTime.parse(json['publishTime']),
    );
    return article;
  }

  Map<String,dynamic> toJson() => <String,dynamic>{
    'code': code,
    'articleName': articleName,
    'articleIcons': articleIcons,
    'articleType': articleType,
    'affiliation': affiliation,
    'author': author,
    'biologyCode': biologyCode,
    'intro': intro,
    'enabled': enabled,
    'salesStatus': salesStatus,
    'discounts': discounts,
    'salePrice': salePrice,
    'saleTime': saleTime,
    'selloutTime': selloutTime,
    'publishTime': publishTime
  };

}
