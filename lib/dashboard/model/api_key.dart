import 'package:fluuter_dashboard/dashboard/model/generic_api_%20model.dart';

class ApiKey extends GenericApiModel {
  final String id; // Make id a required field
  final bool isEnabled; // Make isEnabled a required field

  ApiKey({
    required this.id, // Pass id to the constructor
    required String name, // Pass name to the constructor
    required String url, // Pass url to the constructor
    Map<String, String> headers = const {}, // Pass headers to the constructor
    Map<String, String> params = const {}, // Pass params to the constructor
    required this.isEnabled, // Pass isEnabled to the constructor
  }) : super(id: id, name: name, url: url, headers: headers, params: params);

  // Convert the ApiKey object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'headers': headers,
      'params': params,
      'isEnabled': isEnabled, // Include isEnabled in the map
    };
  }

  // Create an ApiKey object from a map
  factory ApiKey.fromMap(Map<String, dynamic> map) {
    return ApiKey(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      headers: Map<String, String>.from(map['headers']),
      params: Map<String, String>.from(map['params']),
      isEnabled: map['isEnabled'],
    );
  }
}
