import 'package:fluuter_dashboard/dashboard/model/generic_api_%20model.dart';

class AdSource extends GenericApiModel {
  final String id; // Make id a required field
  final bool isEnabled; // Make isEnabled a required field

  AdSource({
    required this.id, // Pass id to the constructor
    required String name, // Pass name to the constructor
    required String url, // Pass url to the constructor
    Map<String, String> headers = const {}, // Pass headers to the constructor
    Map<String, String> params = const {}, // Pass params to the constructor
    required this.isEnabled, // Pass isEnabled to the constructor
  }) : super(id: id, name: name, url: url, headers: headers, params: params);

  // Convert the AdSource object to a map
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

  // Create an AdSource object from a map
  factory AdSource.fromMap(Map<String, dynamic> map) {
    return AdSource(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      headers: Map<String, String>.from(map['headers']),
      params: Map<String, String>.from(map['params']),
      isEnabled: map['isEnabled'],
    );
  }
}
