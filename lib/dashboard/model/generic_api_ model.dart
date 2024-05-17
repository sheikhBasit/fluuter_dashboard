// models/generic_api_model.dart

abstract class GenericApiModel {
  final String id;
  final String name;
  final String url;
  final Map<String, String>? headers; // Nullable headers
  final Map<String, String>? params; // Nullable params
  bool? isEnabled;

  // Constructor
  GenericApiModel({
    required this.id,
    required this.name,
    required this.url,
    this.headers, // Make headers nullable
    this.params, // Make params nullable
    this.isEnabled,
  });

  // Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'headers': headers,
      'params': params,
      'isEnabled': isEnabled,
    };
  }

  // Create an object from a map
  factory GenericApiModel.fromMap(Map<String, dynamic> map) {
    return ConcreteApiModel(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      headers: map['headers'] != null ? Map<String, String>.from(map['headers']) : null,
      params: map['params'] != null ? Map<String, String>.from(map['params']) : null,
      isEnabled: map['isEnabled'],
    );
  }

  // Add a header
  void addHeader(String key, String value) {
    headers?[key] = value;
  }

  // Remove a header
  void removeHeader(String key) {
    headers?.remove(key);
  }

  // Add a parameter
  void addParam(String key, String value) {
    params?[key] = value;
  }

  // Remove a parameter
  void removeParam(String key) {
    params?.remove(key);
  }
}

// models/concrete_api_model.dart

class ConcreteApiModel extends GenericApiModel {
  ConcreteApiModel({
    required String id,
    required String name,
    required String url,
    Map<String, String>? headers, // Nullable headers
    Map<String, String>? params, // Nullable params
    bool? isEnabled,
  }) : super(
          id: id,
          name: name,
          url: url,
          headers: headers,
          params: params,
          isEnabled: isEnabled,
        );
}
