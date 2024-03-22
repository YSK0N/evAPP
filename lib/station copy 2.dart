// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StationInformationPage extends StatefulWidget {
//   @override
//   _StationInformationPageState createState() => _StationInformationPageState();
// }

// class _StationInformationPageState extends State<StationInformationPage> {
//   late Future<List<StationInformation>> _stationInformationData;
//   TextEditingController _searchController = TextEditingController();

//   Future<List<StationInformation>> _fetchStationInformationData(
//       {String? searchQuery}) async {
//     final response = await http.get(
//       Uri.parse(
//           'http://localhost:80/projice/ev_backen/ev_backen/api/station_show.php'),
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> parsed = json.decode(response.body);

//       // Filter the data based on the search query
//       if (searchQuery != null && searchQuery.isNotEmpty) {
//         return parsed
//             .where((station) =>
//                 station['station_name'] != null &&
//                 station['station_name'].toString().contains(searchQuery))
//             .map((json) => StationInformation.fromJson(json))
//             .toList();
//       } else {
//         return parsed.map((json) => StationInformation.fromJson(json)).toList();
//       }
//     } else {
//       throw Exception('ไม่สามารถโหลดข้อมูลจาก API ได้');
//     }
//   }

//   Future<void> _deleteData(String stationId) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:8080/API_MN641463007/Station/delete.php'),
//       body: {
//         'station_id': stationId,
//       },
//     );

//     // if (response.statusCode == 200) {
//     //   setState(() {
//     //     _stationInformationData = _fetchStationInformationData();
//     //   });
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       content: Text('ลบข้อมูลสำเร็จ'),
//     //     ),
//     //   );
//     // } else {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       content: Text('เกิดข้อผิดพลาดในการลบข้อมูล'),
//     //     ),
//     //   );
//     // }
//   }

//   Future<void> _editData(
//       String stationId,
//       String stationName,
//       String email,
//       String phone,
//       String address,
//       String image,
//       String details,
//       String createdDate,
//       String status,
//       String gps) async {
//     TextEditingController stationNameController =
//         TextEditingController(text: stationName);
//     TextEditingController emailController = TextEditingController(text: email);
//     TextEditingController phoneController = TextEditingController(text: phone);
//     TextEditingController addressController =
//         TextEditingController(text: address);
//     TextEditingController imageController = TextEditingController(text: image);
//     TextEditingController detailsController =
//         TextEditingController(text: details);
//     TextEditingController createdDateController =
//         TextEditingController(text: createdDate);
//     TextEditingController statusController =
//         TextEditingController(text: status);
//     TextEditingController gpsController = TextEditingController(text: gps);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('แก้ไขข้อมูลสถานี'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('รหัสสถานี: $stationId'),
//               TextField(
//                 controller: stationNameController,
//                 decoration: InputDecoration(
//                   labelText: 'ชื่อสถานี',
//                   contentPadding: EdgeInsets.all(8),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: 'อีเมล',
//                   contentPadding: EdgeInsets.all(8),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               // Add more fields based on your data model
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('ยกเลิก'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 // Implement the logic to update data
//                 // You'll need to modify this part based on your backend API
//                 final response = await http.post(
//                   Uri.parse(
//                       'http://localhost:8080/API_MN641463007/Station/update.php'),
//                   body: {
//                     'station_id': stationId,
//                     'station_name': stationNameController.text,
//                     'email': emailController.text,
//                     'phone': phoneController.text,
//                     'addrss': addressController.text,
//                     'image': imageController.text,
//                     'details': detailsController.text,
//                     'created_date': createdDateController.text,
//                     'status': statusController.text,
//                     'GPS': gpsController.text,
//                   },
//                 );

//                 if (response.statusCode == 200) {
//                   setState(() {
//                     _stationInformationData = _fetchStationInformationData();
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('อัปเดตข้อมูลสถานีสำเร็จ'),
//                     ),
//                   );
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('เกิดข้อผิดพลาดในการอัปเดตข้อมูลสถานี'),
//                     ),
//                   );
//                 }
//               },
//               child: Text(
//                 'บันทึกข้อมูล',
//                 style: TextStyle(color: Colors.green),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _stationInformationData = _fetchStationInformationData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('หน้าข้อมูลสถานี'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: 200,
//               child: TextField(
//                 controller: _searchController,
//                 onChanged: (value) {
//                   setState(() {
//                     _stationInformationData =
//                         _fetchStationInformationData(searchQuery: value);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'ค้นหาชื่อสถานี',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<StationInformation>>(
//         future: _stationInformationData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('ข้อผิดพลาด: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('ไม่พบข้อมูล'));
//           } else {
//             return SingleChildScrollView(
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: DataTable(
//                     columnSpacing: 20,
//                     headingRowColor: MaterialStateColor.resolveWith(
//                         (states) => Colors.blueAccent),
//                     columns: <DataColumn>[
//                       DataColumn(label: Text('ชื่อสถานี')),
//                       DataColumn(label: Text('อีเมล')),
//                       DataColumn(label: Text('แก้ไข')),
//                       DataColumn(label: Text('ลบ')),
//                     ],
//                     rows: snapshot.data!.map((data) {
//                       return DataRow(
//                         cells: <DataCell>[
//                           DataCell(
//                               Center(child: Text(data.stationName.toString()))),
//                           DataCell(Center(child: Text(data.email.toString()))),
//                           DataCell(
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 _editData(
//                                   data.stationId,
//                                   data.stationName,
//                                   data.email,
//                                   data.phone,
//                                   data.address,
//                                   data.image,
//                                   data.details,
//                                   data.createdDate,
//                                   data.status,
//                                   data.gps,
//                                 );
//                               },
//                             ),
//                           ),
//                           DataCell(
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 _deleteData(data.stationId.toString());
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _navigateToAddStationInformation();
//         },
//         child: Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

// class _navigateToAddStationInformation {}

// class StationInformation {
//   final String stationId;
//   final String stationName;
//   final String email;
//   final String phone;
//   final String address;
//   final String image;
//   final String details;
//   final String createdDate;
//   final String status;
//   final String gps;

//   StationInformation({
//     required this.stationId,
//     required this.stationName,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.image,
//     required this.details,
//     required this.createdDate,
//     required this.status,
//     required this.gps,
//   });

//   factory StationInformation.fromJson(Map<String, dynamic> json) {
//     return StationInformation(
//       stationId: json['station_id'] ?? '',
//       stationName: json['station_name'] ?? '',
//       email: json['email'] ?? '',
//       phone: json['phone'] ?? '',
//       address: json['addrss'] ?? '',
//       image: json['image'] ?? '',
//       details: json['details'] ?? '',
//       createdDate: json['created_date'] ?? '',
//       status: json['status'] ?? '',
//       gps: json['GPS'] ?? '',
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: StationInformationPage(),
//   ));
// }
