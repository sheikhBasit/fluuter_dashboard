import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/dashboard/controller/live_streaming_source_controller.dart';
import 'package:fluuter_dashboard/dashboard/model/live_streaming_source.dart';
import 'package:provider/provider.dart';

class LiveStreamingSourceSection extends StatefulWidget {
  @override
  State<LiveStreamingSourceSection> createState() => _LiveStreamingSourceSectionState();
}

class _LiveStreamingSourceSectionState extends State<LiveStreamingSourceSection> {
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  final List<Map<String, String>> additionalHeaders = [{'key': '', 'value': ''}];
  final List<Map<String, String>> additionalParams = [{'key': '', 'value': ''}];
  bool isHotMatch = false; // Initially, it's not a hot match

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

Future<void> _hitApiAndSaveToFirestore() async {
  try {
    // Fetch data from the API
    // Example: http.Response response = await http.get(apiUrl);

    // Parse the response data
    // Example: dynamic responseData = json.decode(response.body);

    // Add logic to parse the response and obtain relevant data

    // Store the obtained data into Firestore
    // Example: await _controller.addDataToFirestore(data, collectionName);
  } catch (error) {
    print('Error hitting API and saving to Firestore: $error');
    // Handle error
  }
}

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LiveStreamingSourceController>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your existing UI elements

            ElevatedButton(
              onPressed: _hitApiAndSaveToFirestore,
              child: Text('Hit API and Save to Firestore'),
            ),

            // Your existing UI elements

            // Fetch and display live streaming sources from Firestore
            FutureBuilder<List<LiveStreamingSource>>(
              future: controller.fetchLiveStreamingSources(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final sources = snapshot.data ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live Streaming Sources:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: sources.length,
                        itemBuilder: (context, index) {
                          final source = sources[index];
                          return ListTile(
                            title: Text(source.name),
                            subtitle: Text(source.url),
                            trailing: Switch(
                              value: source.isEnabled ?? false,
                              onChanged: (value) {
                                // Update isEnabled state
                                controller.updateIsEnabled(source.id, value);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
