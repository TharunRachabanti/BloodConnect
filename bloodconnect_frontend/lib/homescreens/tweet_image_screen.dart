import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';

class TweetImageScreen extends StatelessWidget {
  final TweetImageModel tweetImageModel;
  final DateTime timestamp;

  TweetImageScreen({
    required this.tweetImageModel,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 15, // Adjust the radius as needed
                      backgroundImage: AssetImage(
                        'assets/images/mine.jpeg', // Provide the path to the user profile photo
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Adjust the width as needed
                  Text(
                    tweetImageModel.Username ?? '',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.more_vert, color: Colors.black),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
                  child: Text(
                    'Message: ${tweetImageModel.Message ?? ''}',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
                  child: Text(
                    'Timestamp: ${_formatTimestamp(timestamp)}',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(tweetImageModel.Imageurl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () {},
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () {},
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.share_outlined),
                  onPressed: () {},
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    String formattedTimestamp =
        DateFormat('HH:mm:ss dd-MM-yyyy').format(timestamp.toLocal());
    return formattedTimestamp;
  }
}
