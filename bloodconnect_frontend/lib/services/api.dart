import 'dart:convert';

import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.40.33:3000/api/";

  static addrequesterdata(Map rdata) async {
    print(rdata);
    var url = Uri.parse("${baseUrl}add_requesterdata");

    try {
      final res = await http.post(url, body: rdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        //
      } else {
        print("Failed to get response");
        //
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //get method
  static getrequestersdata() async {
    List<RequesterData> Requestersdata = [];

    var url = Uri.parse("${baseUrl}get_requesteddetails");

    try {
      final res = await http.get(url);

      if (res.statusCode == 200) {
        //
        var data = jsonDecode(res.body);
        data['Requestersdata'].forEach(
          (value) => {
            Requestersdata.add(
              RequesterData(
                name: value['rname'],
                bloodgroup: value['rbloodgroup'],
                gender: value['rgender'],
                address: value['raddress'],
                phonenumber: value['rphonenumber'],
                tag: value['rtag'],
              ),
            )
          },
        );
        return Requestersdata;
      } else {
        return [];
        //
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
