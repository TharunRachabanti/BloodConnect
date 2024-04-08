import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Api.getImageMessages(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TweetImageModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<TweetImageModel> data = snapshot.data!.toList();
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                TweetImageModel tweetImageModeldata = data[index];
                return Card(
                  child: ListTile(
                    title: Text(tweetImageModeldata.Message ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('message: ${tweetImageModeldata.Message ?? ''}'),
                        Image.network(
                          tweetImageModeldata.Imageurl ?? '',
                          width: 200, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
