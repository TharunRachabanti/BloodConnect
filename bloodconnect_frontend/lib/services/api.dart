import 'dart:convert';

import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "https://bloodconnect-server.onrender.com/api/";

  static Future<void> addrequesterdata(Map<String, dynamic> rdata,
      bool showInProfile, String currentUsername) async {
    var url = Uri.parse("${baseUrl}add_requesterdata");

    try {
      final res = await http.post(url, body: {
        ...rdata,
        "showInProfile": showInProfile.toString(),
        "username": currentUsername, // Include current username in the request
      });

      if (res.statusCode == 200) {
        var responseData = jsonDecode(res.body);
        print("Request successfully added with showInProfile: $showInProfile");
      } else {
        print("Failed to add request");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<RequesterData>> getrequestersdata() async {
    List<RequesterData> requestersData = [];

    var url = Uri.parse("${baseUrl}get_requesteddetails");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) {
          requestersData.add(RequesterData(
            name: value['rname'],
            bloodgroup: value['rbloodgroup'],
            gender: value['rgender'],
            address: value['raddress'],
            phonenumber: value['rphonenumber'],
            tag: value['rtag'],
            showInProfile: value['showInProfile'],
            createdAt: DateTime.parse(value['createdAt']), // Parse timestamp
            username: value['username'], // Include the username
          ));
        });
        return requestersData;
      } else {
        return []; // Return empty list if status code is not 200
      }
    } catch (e) {
      print(e.toString());
      return []; // Return empty list in case of error
    }
  }

  static Future<void> uploadImageData(
      String imageUrl, String message, String currentUsername) async {
    var url = Uri.parse("${baseUrl}store_image_message");

    try {
      final res = await http.post(url, body: {
        "imageUrl": imageUrl,
        "message": message,
        "username": currentUsername, // Pass current username to the backend
      });

      if (res.statusCode == 200) {
        var responseData = jsonDecode(res.body);
        print("Image data uploaded successfully");
      } else {
        print("Failed to upload image data. Status code: ${res.statusCode}");
        print("Response body: ${res.body}");
      }
    } catch (e) {
      print("Error uploading image data: $e");
    }
  }

  static Future<void> uploadDonateImageData(
      String imageUrl, String message, String username) async {
    var url = Uri.parse(
        "${baseUrl}store_donate_image_message"); // Update the endpoint URL

    try {
      final res = await http.post(url, body: {
        "imageUrl": imageUrl,
        "message": message,
        "username": username, // Pass the current user's name to the backend
      });

      // Handle response based on status code
      if (res.statusCode == 200) {
        var responseData = jsonDecode(res.body);
        print("Image data uploaded successfully");
      } else {
        print("Failed to upload image data. Status code: ${res.statusCode}");
        print("Response body: ${res.body}");
      }
    } catch (e) {
      print("Error uploading image data: $e");
    }
  }

  static Future<List<TweetImageModel>> getImageMessages() async {
    List<TweetImageModel> imageMessages = [];

    var url = Uri.parse("${baseUrl}get_image_message");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) {
          imageMessages.add(TweetImageModel(
            Username: value['username'],
            Imageurl: value['imageUrl'],
            Message: value['message'],
            createdAt: DateTime.parse(
                value['createdAt']), // Parse timestamp from string
          ));
        });
        return imageMessages;
      } else {
        return []; // Return empty list if status code is not 200
      }
    } catch (e) {
      print(e.toString());
      return []; // Return empty list in case of error
    }
  }

  static Future<List<TweetImageModel>> getDonateImageMessages() async {
    List<TweetImageModel> imageMessages = [];

    var url = Uri.parse("${baseUrl}get_Donate_image_message");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        data.forEach((value) {
          imageMessages.add(TweetImageModel(
            Username: value['username'],
            Imageurl: value['imageUrl'],
            Message: value['message'],
            createdAt: DateTime.parse(
                value['createdAt']), // Parse timestamp from string
          ));
        });
        return imageMessages;
      } else {
        return []; // Return empty list if status code is not 200
      }
    } catch (e) {
      print(e.toString());
      return []; // Return empty list in case of error
    }
  }

  static Future<List<Map<String, dynamic>>> getUsersDataFromFirestore() async {
    List<Map<String, dynamic>> usersData = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      querySnapshot.docs.forEach((doc) {
        usersData.add(doc.data());
      });
      return usersData;
    } catch (e) {
      print("Error fetching data from Firestore: $e");
      return []; // Return empty list in case of error
    }
  }
}
