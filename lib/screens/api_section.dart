
import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/dashboard/controller/api_key_controller.dart';
import 'package:fluuter_dashboard/dashboard/model/api_key.dart';
import 'package:uuid/uuid.dart';

class ApiKeySection extends StatefulWidget {
  @override
  _ApiKeySectionState createState() => _ApiKeySectionState();
}

class _ApiKeySectionState extends State<ApiKeySection> {
  final ApiKeyController _controller = ApiKeyController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _headerKeyController = TextEditingController();
  final TextEditingController _headerValueController = TextEditingController();
  final TextEditingController _paramKeyController = TextEditingController();
  final TextEditingController _paramValueController = TextEditingController();
  final List<Map<String, String>> additionalHeaders = [{'key': '', 'value': ''}];
  final List<Map<String, String>> additionalParams = [{'key': '', 'value': ''}];

  String selectedApiEndpoint = 'games'; // Initial value for dropdown

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedApiEndpoint,
              onChanged: (value) {
                setState(() {
                  selectedApiEndpoint = value!;
                });
              },
              items: <String>['games', 'standings', 'recent matches', 'teams']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'API Key URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildAdditionalFields('Additional Headers:', additionalHeaders, _addHeader),
            const SizedBox(height: 16.0),
            _buildAdditionalFields('Additional Parameters:', additionalParams, _addParam),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addApiSource,
              child: const Text('Add API Key'),
            ),
            const SizedBox(height: 16.0),
            _buildApiKeyList(),
          ],
        ),
      ),
    );
  }

  Widget _buildApiKeyList() {
    return FutureBuilder<List<ApiKey>>(
      future: _controller.fetchApiKeys(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final apiKeys = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: apiKeys.map((apiKey) {
              return ListTile(
                title: Text(apiKey.name),
                subtitle: Text(apiKey.url),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Implement edit functionality
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _controller.removeApiKey(apiKey.id);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

 

  void _addHeader() {
    setState(() {
      additionalHeaders.add({'key': '', 'value': ''});
    });
  }

  void _addParam() {
    setState(() {
      additionalParams.add({'key': '', 'value': ''});
    });
  }
 Future <void> _addApiSource () async{
    String id = const Uuid().v4();

    if (_urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('URL cannot be empty'),
        ),
      );
      return;
    }

    Map<String, String> headers = {};
    if (_headerKeyController.text.isNotEmpty) {
      additionalHeaders.forEach((header) {
        if (header['key']!.isNotEmpty) {
          headers[header['key'] ?? ''] = header['value'] ?? '';
        }
      });
      headers[_headerKeyController.text] = _headerValueController.text;
    }

    Map<String, String> params = {};
    if (_paramKeyController.text.isNotEmpty) {
      additionalParams.forEach((param) {
        if (param['key']!.isNotEmpty) {
          params[param['key'] ?? ''] = param['value'] ?? '';
        }
      });
      params[_paramKeyController.text] = _paramValueController.text;
    }

    ApiKey  apiKey = ApiKey(
      id: id,
      name: selectedApiEndpoint,
      url: _urlController.text,
      headers: headers,
      params: params,
      isEnabled: true,
    );

      await _controller.addApiKey(apiKey);
      await _controller.fetchDataFromApiPeriodically(selectedApiEndpoint, _urlController.text, headers, params, (dynamic apiData) async {
        // Store data in Firestore with the selected collection name
      await _controller.storeDataFromApi(selectedApiEndpoint, apiData);
      });
    _urlController.clear();
    _headerKeyController.clear();
    _headerValueController.clear();
    _paramKeyController.clear();
    _paramValueController.clear();
    additionalHeaders.clear();
    additionalParams.clear();
  }


  Widget _buildAdditionalFields(String title, List<Map<String, String>> fields, void Function() addField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        ...fields.map((field) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Key',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => field['key'] = value,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Value',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => field['value'] = value,
                ),
              ),
            ],
          );
        }).toList(),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: addField,
        ),
      ],
    );
  }
}
