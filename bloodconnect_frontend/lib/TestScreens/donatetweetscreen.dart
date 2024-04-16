import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class DonateTweetScreen extends StatelessWidget {
  const DonateTweetScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DonateTweetScreen"),
      ),
      body: FutureBuilder(
        future: Api.getDonateImageMessages(),
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
                        Text(
                            'Timestamp: ${tweetImageModeldata.createdAt.toString()}'), // Display timestamp
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
