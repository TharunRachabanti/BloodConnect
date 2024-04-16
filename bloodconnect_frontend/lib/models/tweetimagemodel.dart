class TweetImageModel {
  final String? Imageurl;
  final String? Message;
  final String? Username; // Add username field
  final DateTime? createdAt;

  TweetImageModel({
    this.Imageurl,
    this.Message,
    this.createdAt,
    this.Username,
  });
}
