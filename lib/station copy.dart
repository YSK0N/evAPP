class Station {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String imageUrl;
  final String details;
  final String status;

  Station({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.details,
    required this.status,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      details: json['details'],
      status: json['status'],
    );
  }
}
