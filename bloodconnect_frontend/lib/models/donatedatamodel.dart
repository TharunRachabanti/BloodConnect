import 'package:cloud_firestore/cloud_firestore.dart';

class DonateData {
  final String? name;
  final String? age;
  final String? bloodGroup;
  final String? sex;
  final String? address;
  final Timestamp? timestamp; // Add timestamp field

  DonateData({
    this.name,
    this.age,
    this.bloodGroup,
    this.sex,
    this.address,
    this.timestamp,
  });
}
