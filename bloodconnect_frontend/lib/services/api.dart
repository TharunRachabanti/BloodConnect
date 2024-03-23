import 'dart:convert';

import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.40.33:3000/api/";

  static Future<void> addrequesterdata(
      Map<String, dynamic> rdata, bool showInProfile) async {
    var url = Uri.parse("${baseUrl}add_requesterdata");

    try {
      final res = await http.post(url, body: {
        ...rdata,
        "showInProfile": showInProfile.toString(),
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

  //get method
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
            showInProfile:
                value['showInProfile'], // Include showInProfile field
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
}
