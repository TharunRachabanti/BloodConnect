import 'package:flutter/material.dart';
import 'package:bloodconnect_frontend/homescreens/donate_image_screen.dart';
import 'package:bloodconnect_frontend/homescreens/firestore_data_screen.dart';
import 'package:bloodconnect_frontend/homescreens/requester_data_screen.dart';
import 'package:bloodconnect_frontend/homescreens/tweet_image_screen.dart';
import 'package:bloodconnect_frontend/models/combinedmodel.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/models/tweetimagemodel.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the screen initializes
  }

  void _fetchData() {
    _futureData = Future.wait([
      Api.getrequestersdata(), // Fetch data from Collection 1 (requester data)
      Api.getImageMessages(), // Fetch data from Collection 2 (tweet images)
      Api.getUsersDataFromFirestore(), // Fetch data from Firestore
      Api.getDonateImageMessages(), // Fetch data from Collection 3 (donate images)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.redAccent.withOpacity(0.5),
        centerTitle: false,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.red, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Column(
            children: [
              Text(
                'Blood Connect',
                style: GoogleFonts.getFont(
                    'Abril Fatface', // Replace 'Roboto' with the desired font from Google Fonts
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
              //SizedBox(height: 5),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important_rounded, color: Colors.red),
            onPressed: () {
              // Add your notifications action here
            },
            splashColor: Colors.red,
            highlightColor: Colors.red[200],
            iconSize: 30.0,
          ),
          IconButton(
            icon: Icon(Icons.saved_search_rounded, color: Colors.red),
            onPressed: () {
              // Add your search action here
            },
            splashColor: Colors.red,
            highlightColor: Colors.red[200],
            iconSize: 30.0,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            height: 4.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            // Combine data into a single list
            List<CombinedData> combinedDataList = [];

            // Add data from Collection 1 (requester data)
            combinedDataList.addAll(_buildCombinedDataList(
              snapshot.data![0],
              "Collection1",
              (data) => data.createdAt ?? DateTime.now(),
            ));

            // Add data from Collection 2 (tweet images)
            combinedDataList.addAll(_buildCombinedDataList(
              snapshot.data![1],
              "Collection2",
              (data) => data.createdAt ?? DateTime.now(),
            ));

            // Add data from Firestore
            combinedDataList.addAll(_buildCombinedDataList(
              snapshot.data![2],
              "Firestore",
              (data) => data['timestamp']?.toDate() ?? DateTime.now(),
            ));

            // Add data from Collection 3 (donate images)
            combinedDataList.addAll(_buildCombinedDataList(
              snapshot.data![3],
              "Collection3",
              (data) => data.createdAt ?? DateTime.now(),
            ));

            // Sort the combined data by timestamp (descending order)
            combinedDataList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

            return Stack(
              children: [
                ListView.builder(
                  itemCount: combinedDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildListItem(context, combinedDataList[index]);
                  },
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5 -
                      450, // Adjust the top position according to your requirement
                  left: MediaQuery.of(context).size.width * 0.5 -
                      35, // Adjust the left position according to your requirement
                  child: Container(
                    width: 70, // Adjust the width of the circular container
                    height: 70, // Adjust the height of the circular container
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),

                    child: Align(
                      alignment: Alignment
                          .bottomCenter, // Align the text to the bottom of the container
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 8.0), // Add some bottom padding to the text
                        child: Text(
                          "O+",
                          style: GoogleFonts.dmSerifText(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  List<CombinedData> _buildCombinedDataList(
    List<dynamic> dataList,
    String collectionType,
    DateTime Function(dynamic) timestampExtractor,
  ) {
    return dataList.map((data) {
      return CombinedData(
        collectionType: collectionType,
        data: data,
        timestamp: timestampExtractor(data),
      );
    }).toList();
  }

  Widget _buildListItem(BuildContext context, CombinedData combinedData) {
    switch (combinedData.collectionType) {
      case "Collection1":
        return RequesterDataScreen(
          requesterData: combinedData.data as RequesterData,
          timestamp: combinedData.timestamp,
        );
      case "Collection2":
        return TweetImageScreen(
          tweetImageModel: combinedData.data as TweetImageModel,
          timestamp: combinedData.timestamp,
        );
      case "Collection3":
        return DonateImageScreen(
          donateImageModel: combinedData.data as TweetImageModel,
          timestamp: combinedData.timestamp,
        );
      case "Firestore":
        return FirestoreDataScreen(
          data: combinedData.data as Map<String, dynamic>,
          timestamp: combinedData.timestamp,
        );
      default:
        return Container();
    }
  }
}
