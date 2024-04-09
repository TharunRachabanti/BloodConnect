import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Future.wait([
          Api.getrequestersdata(),
          Api.getImageMessages(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<RequesterData> requesterDataList =
                snapshot.data![0].cast<RequesterData>();
            List<TweetImageModel> imageMessagesList =
                snapshot.data![1].cast<TweetImageModel>();

            // Combine both lists into a single list
            List<dynamic> combinedList = [
              ...requesterDataList,
              ...imageMessagesList
            ];

            // Sort the combined list based on timestamp (assuming timestamp field exists)
            combinedList.sort((a, b) {
              // Assuming a.timestamp and b.timestamp are DateTime objects
              return b.timestamp.compareTo(a.timestamp); // Descending order
            });

            return ListView.builder(
              itemCount: combinedList.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic item = combinedList[index];

                if (item is RequesterData) {
                  // Handle RequesterData item
                  return Card(
                    child: ListTile(
                      title: Text(item.name ?? ''),
                      subtitle: Text('Blood Group: ${item.bloodgroup ?? ''}'),
                      // Add more fields as needed
                    ),
                  );
                } else if (item is TweetImageModel) {
                  // Handle TweetImageModel item
                  return Card(
                    child: ListTile(
                      title: Text(item.Message ?? ''),
                      subtitle: Image.network(
                        item.Imageurl ?? '',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(); // Handle other types of data if any
                }
              },
            );
          }
        },
      ),
    );
  }
}
