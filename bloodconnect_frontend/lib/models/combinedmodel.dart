import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';

class CombinedData {
  final String collectionType;
  final dynamic data;
  final DateTime timestamp;

  CombinedData({
    required this.collectionType,
    required this.data,
    required this.timestamp,
  });
}
