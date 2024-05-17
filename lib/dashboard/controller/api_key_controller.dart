import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import Timer

import 'package:fluuter_dashboard/dashboard/model/api_key.dart';
import 'package:fluuter_dashboard/dashboard/services/firestore_services.dart';

class ApiKeyController {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isDataFetched = false;

  Future<List<ApiKey>> fetchApiKeys() async {
  try {
    List<ApiKey> apiKeys = await _firestoreService.getApiKeys();
    // Handle the fetched API keys (e.g., update state)
    return apiKeys;
  } catch (error) {
    print('Error fetching API keys: $error');
    // Handle error
    return []; // Return an empty list in case of an error
  }
}

  Future<void> addApiKey(ApiKey apiKey) async {
    try {
      await _firestoreService.addApiKey(apiKey);
      print('add {$apiKey}');
      // Handle success (e.g., fetch API keys again to update state)
    } catch (error) {
      print('Error adding API key: $error');
      // Handle error
    }
  }

  Future<void> removeApiKey(String id) async {
    try {
      await _firestoreService.removeApiKey(id);
      // Handle success (e.g., fetch API keys again to update state)
    } catch (error) {
      print('Error removing API key: $error');
      // Handle error
    }
  }

  Future<void> storeApiOnFirestore(String collection,String url, Map<String, String> headers, Map<String,String> params) async {
    try {
      // Fetch API data
      if(params!=null){
      print(params);
      String queryString = Uri(queryParameters: params).query;
      String requestUrl = url + '?' + queryString;
      
      print(requestUrl);
    
      http.Response response = await http.get(Uri.parse(requestUrl), headers: headers);
      dynamic apiData = json.decode(response.body);
      print('response: $response');
      // Store API data on Firestore
      await storeDataFromApi(collection,apiData);

      // Set _isDataFetched to true to indicate that API data is stored
      _isDataFetched = true;}
      else if(params == {}){ 
           http.Response response = await http.get(Uri.parse(url), headers: headers);
      dynamic apiData = json.decode(response.body);
      print('response: $response');
      // Store API data on Firestore
      await storeDataFromApi(collection,apiData);

      // Set _isDataFetched to true to indicate that API data is stored
      _isDataFetched = true;
      }
    } catch (error) {
      print('Error storing API data on Firestore: $error');
      // Handle error
    }
  }

 Future<void> fetchDataFromApiPeriodically(String collection, String url, Map<String, String> headers, Map<String, String> params, Function(dynamic) onDataFetched) async {
    // Check if data is already fetched
    if (!_isDataFetched) {
      await storeApiOnFirestore(collection, url, headers, params);
    }

    // Set up a periodic timer to check for updates
    const Duration checkInterval = Duration(minutes: 15); // Check every 15 minutes
    Timer.periodic(checkInterval, (Timer timer) async {
      try {
        if (params != null) {
          print(params);
          String queryString = Uri(queryParameters: params).query;
          String requestUrl = url + '?' + queryString;
          print(requestUrl);

          // Fetch data from API
          http.Response response = await http.get(Uri.parse(requestUrl), headers: headers);
          dynamic newData = json.decode(response.body);

          // Store new data on Firestore
          await storeDataFromApi(collection, newData);

          // Invoke the callback function with the fetched data
          onDataFetched(newData);
        }
      } catch (error) {
        print('Error fetching data from API: $error');
        // Handle error
      }
    });
  }

Future<void> storeDataFromApi(String collectionName, dynamic data) async {
  try {
    // Store data in Firestore
    await _firestoreService.storeDataFromApi(data, collectionName);
    print('Data from API stored successfully in Firestore');
  } catch (error) {
    print('Error storing data from API in Firestore: $error');
    // Handle error
  }
}


}
