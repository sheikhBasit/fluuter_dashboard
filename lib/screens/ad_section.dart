import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/dashboard/controller/ad_source_controller.dart';
import 'package:fluuter_dashboard/dashboard/model/ad_source.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AdSourceSection extends StatefulWidget {
  @override
  _AdSourceSectionState createState() => _AdSourceSectionState();
}

class _AdSourceSectionState extends State<AdSourceSection> {
  AdSourceController adSourceController = Get.put(AdSourceController());

  TextEditingController _urlController = TextEditingController();
  TextEditingController _headerKeyController = TextEditingController();
  TextEditingController _headerValueController = TextEditingController();
  TextEditingController _paramKeyController = TextEditingController();
  TextEditingController _paramValueController = TextEditingController();

  List<Map<String, String>> additionalHeaders = [{'key': '', 'value': ''}];
  List<Map<String, String>> additionalParams = [{'key': '', 'value': ''}];

  @override
  void initState() {
    super.initState();
    adSourceController.fetchAdSources();
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

  void _addAdSource() {
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

    AdSource adSource = AdSource(
      id: id,
      name: '',
      url: _urlController.text,
      headers: headers,
      params: params,
      isEnabled: true,
    );

    adSourceController.addAdSource(adSource);

    _urlController.clear();
    _headerKeyController.clear();
    _headerValueController.clear();
    _paramKeyController.clear();
    _paramValueController.clear();
    additionalHeaders.clear();
    additionalParams.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Wrap with SingleChildScrollView
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Ad Source',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildAdditionalFields('Additional Headers:', additionalHeaders, _addHeader),
            const SizedBox(height: 8.0),
            _buildAdditionalFields('Additional Parameters:', additionalParams, _addParam),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addAdSource,
              child: const Text('Add Ad Source'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Existing Ad Sources',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Obx(() {
              if (adSourceController.AdSources.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: adSourceController.AdSources.length,
                  itemBuilder: (context, index) {
                    AdSource adSource = adSourceController.AdSources[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'URL: ${adSource.url}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Headers:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...adSource.headers!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('${entry.key}: ${entry.value}'),
                          );
                        }).toList(),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Params:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...adSource.params!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('${entry.key}: ${entry.value}'),
                          );
                        }).toList(),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Implement edit functionality
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                adSourceController.removeAdSource(adSource.id);
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalFields(String title, List<Map<String, String>> fields, void Function() addField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
