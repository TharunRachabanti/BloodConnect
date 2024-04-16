import 'package:bloodconnect_frontend/DonateScreens/donatescreen1.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen2.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen3.dart';
import 'package:bloodconnect_frontend/TestScreens/requestcardscreen.dart';
import 'package:bloodconnect_frontend/models/requesterdata_model.dart';
import 'package:bloodconnect_frontend/services/api.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Donate',
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Colors.green, Colors.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 2, vertical: 5), // Adjust padding here
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  controller: tabController,
                  tabs: const [
                    _StyledTab('YourBlood\nGroupSeekers'),
                    _StyledTab('OtherBlood\nGroupSeekers'),
                    _StyledTab('Tweet'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    FutureBuilder<List<RequesterData>>(
                      future: Api.getrequestersdata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<RequesterData>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No data available'));
                        }
                        List<RequesterData> rdata = snapshot.data!
                            .where((data) => data.bloodgroup == 'O+')
                            .toList();
                        return ListView.builder(
                          itemCount: rdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            RequesterData requesterData = rdata[index];
                            return Card(
                              child: ListTile(
                                title: Text(requesterData.name ?? ''),
                                subtitle: _buildSubtitle(
                                    requesterData), // Fix this line
                              ),
                            );
                          },
                        );
                      },
                    ),
                    OtherBloodGroupsScreen(),
                    DonateScreen3(),
                    // _TextTabContent('Tab 3'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(RequesterData requesterData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Blood Group: ${requesterData.bloodgroup ?? ''}'),
        Text('Gender: ${requesterData.gender ?? ''}'),
        Text('Address: ${requesterData.address ?? ''}'),
        Text('Phone Number: ${requesterData.phonenumber ?? ''}'),
        Text('Tag: ${requesterData.tag ?? ''}'),
        Text('Show in Profile: ${requesterData.showInProfile ?? ''}'),
      ],
    );
  }
}

class _StyledTab extends StatelessWidget {
  final String text;

  const _StyledTab(this.text);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
