class RequesterData {
  final String? name;
  final String? bloodgroup;
  final String? gender;
  final String? address;
  final String? phonenumber;
  final String? tag;
  final bool? showInProfile;
  final DateTime? createdAt;
  final String? username; // Include the username field

  RequesterData({
    this.name,
    this.bloodgroup,
    this.gender,
    this.address,
    this.phonenumber,
    this.tag,
    this.showInProfile,
    this.createdAt,
    this.username, // Add the username parameter to the constructor
  });

  toMap() {}
}
