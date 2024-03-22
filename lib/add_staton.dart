import 'package:ev_project/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddStationPage extends StatefulWidget {
  @override
  _AddStationPageState createState() => _AddStationPageState();
}

class _AddStationPageState extends State<AddStationPage> {
  TextEditingController stationNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addrssController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController gpsController = TextEditingController();

  void registerUser() async {
    String stationName = stationNameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String addrss = addrssController.text;
    String image = imageController.text;
    String details = detailsController.text;
    String status = statusController.text;
    String gps = gpsController.text;

    String apiUrl =
        'http://localhost/projice/ev_backen/ev_backen/api/add_station.php';

    Map<String, dynamic> requestBody = {
      'station_name': stationName,
      'email': email,
      'phone': phone,
      'addrss': addrss,
      'image': image,
      'details': details,
      'status': status,
      'GPS': gps,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        showSuccessDialog(context);
      } else {
        print('Registration failed');
      }
    } catch (error) {
      print('Error connecting to the server: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
          },
        ),
        centerTitle: true,
        title: Text('Register'),
        titleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: stationNameController,
              decoration: InputDecoration(labelText: 'Station Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: addrssController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image'),
            ),
            TextFormField(
              controller: detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            TextFormField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            TextFormField(
              controller: gpsController,
              decoration: InputDecoration(labelText: 'GPS'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Register'),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(300, 50),
                side: BorderSide(
                  color: Color.fromARGB(255, 0, 255, 0),
                  width: 2.0,
                ),
                backgroundColor: Color.fromARGB(255, 0, 255, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Your information has been successfully saved.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
            child: Text('Go to Login'),
          ),
        ],
      );
    },
  );
}
