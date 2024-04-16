import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

class FirestoreDataScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final DateTime timestamp;

  FirestoreDataScreen({required this.data, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    data['name'] ?? '',
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
            'assets/images/1212.png',
            data['name'] ??
                '', // Removed unnecessary quotes around data['name']
            data['bloodGroup'] ??
                '', // Removed unnecessary quotes around data['bloodGroup']
            data['age'] ?? '', // Removed unnecessary quotes around data['age']
            data['sex'] ?? '', // Removed unnecessary quotes around data['sex']
            data['address'] ??
                '', // Removed unnecessary quotes around data['address']
            '+91 9347644178',
            ' ${_formatTimestamp(timestamp)}'),
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
}

Widget _buildCard(
    String imagePath,
    String name,
    String bloodGroup, // Made this function private
    String age,
    String gender,
    String address,
    String phoneNumber,
    String timestamp) {
  return Card(
    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    color: Colors.transparent, // Set card color to transparent
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
            fit: BoxFit.fill, // Fill the entire card without distortion
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
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/images/mine.jpeg',
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black54, // Optional: border color
                    width: 1, // Optional: border width
                  ), // Curved borders
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
              _buildInfoRow('Timestamp', timestamp), // Include timestamp here
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
