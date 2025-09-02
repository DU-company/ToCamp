import 'package:hive_flutter/adapters.dart';

part 'recent_keyword_model.g.dart';

@HiveType(typeId: 0)
class RecentKeywordModel extends HiveObject{
  @HiveField(0)
  final String keyword;
  @HiveField(1)
  final DateTime createdAt;

  RecentKeywordModel({required this.keyword, required this.createdAt});
}
