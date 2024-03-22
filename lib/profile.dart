import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  final int userId;

  UserProfile({required this.userId});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'http://your-api-url.com/get_user_api.php?user_id=${widget.userId}'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      // Handle errors
      print('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ListTile(
                  title: Text('Username: ${userData['username']}'),
                ),
                ListTile(
                  title: Text('Email: ${userData['email']}'),
                ),
                ListTile(
                  title: Text('Phone: ${userData['phone']}'),
                ),
                ListTile(
                  title: Text('Date of Birth: ${userData['date']}'),
                ),
                ListTile(
                  title: Text('Status: ${userData['status']}'),
                ),
                // Add more ListTile widgets for other user data
              ],
            ),
    );
  }
}
