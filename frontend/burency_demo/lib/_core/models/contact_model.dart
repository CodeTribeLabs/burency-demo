import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String id;
  String firstName;
  String middleName;
  String lastName;
  String phone;
  String note;
  String address;
  String geoHash;
  double latitude;
  double longitude;

  ContactModel({
    this.id = '',
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.phone = '',
    this.note = '',
    this.address = '',
    this.geoHash = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  factory ContactModel.fromFirestore(
    dynamic jsonData, {
    String docId = '',
  }) {
    if (jsonData == null) {
      return ContactModel();
    }

    final location = jsonData['location'] as GeoPoint;

    return ContactModel(
      id: jsonData['objectID'] ?? docId,
      firstName: jsonData['firstName'] ?? 'Anonymous',
      middleName: jsonData['middleName'] ?? '',
      lastName: jsonData['lastName'] ?? '',
      phone: jsonData['phone'] ?? '',
      note: jsonData['note'] ?? '',
      address: jsonData['address'] ?? '',
      geoHash: jsonData['geoHash'] ?? '',
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  factory ContactModel.from(
    dynamic jsonData, {
    String docId = '',
  }) {
    if (jsonData == null) {
      return ContactModel();
    }

    final location = jsonData['location'];

    return ContactModel(
      id: jsonData['objectID'] ?? docId,
      firstName: jsonData['firstName'] ?? 'Anonymous',
      middleName: jsonData['middleName'] ?? '',
      lastName: jsonData['lastName'] ?? '',
      phone: jsonData['phone'] ?? '',
      note: jsonData['note'] ?? '',
      address: jsonData['address'] ?? '',
      geoHash: jsonData['geoHash'] ?? '',
      latitude: location['_latitude'] ?? 0.0,
      longitude: location['_longitude'] ?? 0.0,
    );
  }

  String get fullName => '$firstName $lastName';

  dynamic toJson() => {
        'id': id,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'phone': phone,
        'note': note,
        'address': address,
        'geoHash': geoHash,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
