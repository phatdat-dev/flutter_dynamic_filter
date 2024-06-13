// get generate model on models/response with assets/import_response.json --copyWith
// get generate model with assets/import_response.json
abstract class BaseModel<R> {
  R fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}

mixin IsSelectedModel<R> on BaseModel<R> {
  bool isSelected = false;
}

/// ```dart
///  @override
///  String get queryName => propHere ?? "";
///  @override
///  set queryName(String value) => queryName = value;
///  @override
///  Object? objectt;
/// ```
abstract class SearchDelegateQueryName {
  String get queryName;
  set queryName(String value) => queryName = value;
  Object? objectt;
}
