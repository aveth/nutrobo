import 'dart:convert';

import 'package:chopper/chopper.dart';

class ModelConverter extends JsonConverter {

  final Map<Type, Function> fromJsonFunctions;

  const ModelConverter(this.fromJsonFunctions);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(response.body, fromJsonFunctions[InnerType]!),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}