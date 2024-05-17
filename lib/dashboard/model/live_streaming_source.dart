// models/live_streaming_source.dart

import 'package:fluuter_dashboard/dashboard/model/generic_api_%20model.dart';

class LiveStreamingSource extends GenericApiModel {
  LiveStreamingSource({
    required String id,
    required String name,
    required String url,
    required Map<String, String> headers,
    required Map<String, String> params,
    required bool isEnabled, // Added isEnabled property
  }) : super(
          id: id,
          name: name,
          url: url,
          headers: headers,
          params: params,
        ) {
    this.isEnabled = isEnabled;
  }

  // Create an object from a map
  factory LiveStreamingSource.fromMap(Map<String, dynamic> map) {
    return LiveStreamingSource(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      headers: Map<String, String>.from(map['headers']),
      params: Map<String, String>.from(map['params']),
      isEnabled: map['isEnabled'] ?? false, // Set default value to false if isEnabled is null
    );
  }

  // Toggle isEnabled state
  void toggleEnabled() {
    isEnabled = isEnabled;
  }
}
