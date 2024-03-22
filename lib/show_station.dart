import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowStationPage extends StatelessWidget {
  final String stationId;

  const ShowStationPage({Key? key, required this.stationId}) : super(key: key);

  Future<Map<String, dynamic>> fetchStationInformation(String stationId) async {
    final response = await http.get(
      Uri.parse(
          'http://localhost/projice/ev_backen/ev_backen/api/station_show.php?station_id=$stationId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load station information: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchStationInformation(stationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('Failed to load station information'),
            ),
          );
        } else {
          var station = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Show Station'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Station ID: ${station['station_id']}'),
                  Text('Station Name: ${station['station_name']}'),
                  Text('Email: ${station['email']}'),
                  Text('Phone: ${station['phone']}'),
                  Text('Address: ${station['address']}'),
                  Text('Image: ${station['image']}'),
                  Text('Details: ${station['details']}'),
                  Text('GPS: ${station['GPS']}'),
                  Text('Status: ${station['status']}'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
