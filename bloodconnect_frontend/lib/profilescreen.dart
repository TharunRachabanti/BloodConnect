import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<RequesterData> data;

  ProfileScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
          future: Api.getrequestersdata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<dynamic> rdata = snapshot.data;

              return ListView.builder(
                  itemCount: rdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.storage),
                      title: Text("${rdata[index].name}"),
                      subtitle: Text("${rdata[index].bloodgroup}"),
                      trailing: Text("\$ ${rdata[index].gender}"),
                    );
                  });
            }
          }),
    );
  }
}
