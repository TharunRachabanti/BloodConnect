import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';

class DonateImageScreen extends StatelessWidget {
  final TweetImageModel donateImageModel;
  final DateTime timestamp;

  DonateImageScreen({required this.donateImageModel, required this.timestamp});

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
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
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
                      donateImageModel.Username ?? '',
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
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
              // Border color set to green
              borderRadius: BorderRadius.circular(12.0),
              // Adjust border radius as needed
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 0.0),
                  child: Text(
                    'Message: ${donateImageModel.Message ?? ''}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black, // Add your desired text color here
                    ),
                    textAlign: TextAlign.left, // Align to the left
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 12.0),
                  child: Text(
                    'Timestamp: ${_formatTimestamp(timestamp)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left, // Align to the left
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
                      image: NetworkImage(donateImageModel.Imageurl ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () => {},
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.comment_outlined),
                  onPressed: () => {},
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.share_outlined),
                  onPressed: () => {},
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
