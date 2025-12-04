import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final List<T> items;

  ApiResponse({required this.items});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final resp = json['response']['body']['items'];
    List<T> pItems = [];

    /// 응닶값은 [ ] 이 아닌 " "으로 오기 때문
    if (resp is! String) {
      final realItems = resp['item'] as List;
      pItems = [...realItems.map((e) => fromJsonT(e))];
    }

    return ApiResponse(items: pItems);
  }
}
