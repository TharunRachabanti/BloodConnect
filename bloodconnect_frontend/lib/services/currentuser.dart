import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getCurrentUserNameFromFirestore() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Check if the document exists and contains the username field
      if (snapshot.exists) {
        // Extract username from the user document
        String? username = snapshot.data()?['name'];

        if (username != null && username.isNotEmpty) {
          // Return the username
          return username;
        }
      }
    }
    // Return a default value or handle the case where username is not found
    return 'Unknown';
  } catch (e) {
    // Handle any errors
    print('Error fetching current user name: $e');
    return 'Unknown';
  }
}
