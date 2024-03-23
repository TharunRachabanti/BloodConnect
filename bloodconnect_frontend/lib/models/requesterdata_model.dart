class RequesterData {
  final String? name;
  final String? bloodgroup;
  final String? gender;
  final String? address;
  final String? phonenumber;
  final String? tag;
  final bool? showInProfile; // New field

  RequesterData({
    this.name,
    this.bloodgroup,
    this.gender,
    this.address,
    this.phonenumber,
    this.tag,
    this.showInProfile, // Include showInProfile in the constructor
  });
}
