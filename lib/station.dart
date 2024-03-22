import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'show_station.dart';

class StationInformation {
  final String stationId;
  final String stationName;
  final String email;
  final String phone;
  final String address;
  final String image;
  final String details;
  final String gps;
  final String status;

  StationInformation({
    required this.stationId,
    required this.stationName,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
    required this.details,
    required this.gps,
    required this.status,
  });

  factory StationInformation.fromJson(Map<String, dynamic> json) {
    return StationInformation(
      stationId: json['station_id'],
      stationName: json['station_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'] ?? '',
      image: json['image'],
      details: json['details'],
      gps: json['GPS'],
      status: json['status'],
    );
  }
}

Future<List<StationInformation>> fetchStationInformation(
    {String? searchQuery}) async {
  final response = await http.get(
    Uri.parse(
        'http://localhost/projice/ev_backen/ev_backen/api/station_show.php'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> parsed = json.decode(response.body);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      return parsed
          .where((station) =>
              station['station_name'] != null &&
              station['station_name'].toString().contains(searchQuery))
          .map((json) =>
              StationInformation.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      return parsed
          .map((json) =>
              StationInformation.fromJson(json as Map<String, dynamic>))
          .toList();
    }
  } else {
    throw Exception(
        'Failed to load station information: ${response.statusCode}');
  }
}

class StationInformationPage extends StatefulWidget {
  @override
  _StationInformationPageState createState() => _StationInformationPageState();
}

class _StationInformationPageState extends State<StationInformationPage> {
  late Future<List<StationInformation>> _stationInformationData;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stationInformationData = fetchStationInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Station Information Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _stationInformationData =
                        fetchStationInformation(searchQuery: value);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search Station Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<StationInformation>>(
        future: _stationInformationData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var station = snapshot.data![index];
                return ListTile(
                  title: Text(station.stationName),
                  subtitle: Text(station.email),
                  onTap: () {
                    _navigateToShowStation(station.stationId);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _navigateToShowStation(String stationId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowStationPage(stationId: stationId),
      ),
    );
  }
}
