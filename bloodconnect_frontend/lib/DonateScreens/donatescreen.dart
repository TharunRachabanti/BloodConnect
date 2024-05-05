import 'package:bloodconnect_frontend/DonateScreens/donatescreen1.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen2.dart';
import 'package:bloodconnect_frontend/DonateScreens/donatescreen3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            style: GoogleFonts.dmSerifDisplay(
              letterSpacing: 2,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Colors.green, Colors.green],
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
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 8), // Adjust padding here
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
                    DonateScreen1(),
                    DonateScreen2(),
                    DonateScreen3(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Mate SC', // Change 'Roboto' to the desired Google Font
            fontSize: 13,
            height: 0.9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
