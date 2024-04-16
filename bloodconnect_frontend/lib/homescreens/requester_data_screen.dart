import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';

class RequesterDataScreen extends StatelessWidget {
  final RequesterData requesterData;
  final DateTime timestamp;

  RequesterDataScreen({required this.requesterData, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
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
                    '${requesterData.username ?? ''}',
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
        _buildCard(
          'assets/images/third.png',
          requesterData.name ?? '',
          '${requesterData.bloodgroup ?? ''}',
          '25', // Assuming age is a static value for now
          '${requesterData.gender ?? ''}',
          '${requesterData.address ?? ''}',
          '${requesterData.phonenumber ?? ''}',
          '${requesterData.tag ?? ''}',
          '${requesterData.showInProfile ?? ''}',
          '${_formatTimestamp(timestamp)}',
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
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    String formattedTimestamp =
        DateFormat('HH:mm:ss dd-MM-yyyy').format(timestamp.toLocal());
    return formattedTimestamp;
  }

  Widget _buildCard(
    String imagePath,
    String name,
    String bloodGroup,
    String age,
    String gender,
    String address,
    String phoneNumber,
    String tag,
    String showInProfile,
    String timestamp,
  ) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.transparent,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/images/mine.jpeg',
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black54,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    name,
                    style: GoogleFonts.dmSerifDisplay(
                      // Use Google Fonts, you can replace 'lobster' with any font from Google Fonts
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        // You can add more text styles like shadows, decoration, etc. here
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                _buildInfoRow('Blood Group', bloodGroup),
                _buildInfoRow('Age', age),
                _buildInfoRow('Gender', gender),
                _buildInfoRow('Address', address),
                _buildInfoRow('Phone Number', phoneNumber),
                _buildInfoRow('Tag', tag),
                _buildInfoRow('Show in Profile', showInProfile),
                _buildInfoRow('Timestamp', timestamp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: GoogleFonts.daysOne(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.dmSerifDisplay(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
