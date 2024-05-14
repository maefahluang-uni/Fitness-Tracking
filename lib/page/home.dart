import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:maincode/componant/bottombar.dart';
import 'package:maincode/componant/globals.dart';
import 'package:intl/intl.dart';

const String _imagePath = 'assets/';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = "Loading..."; // Hold the display name

  @override
  void initState() {
    loadDisplayName(); // Load the display name when the widget is initialized
    super.initState();
  }

  // Load the display name from FirebaseAuth
  void loadDisplayName() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        displayName = FirebaseAuth.instance.currentUser!.displayName.toString();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load the display name when the dependencies change
    loadDisplayName();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracking'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User details
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: FirebaseAuth.instance.currentUser !=
                                null &&
                            FirebaseAuth.instance.currentUser!.photoURL != null
                        ? NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!)
                        : AssetImage('assets/userprofile.png')
                            as ImageProvider<Object>?,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Calendar Bar
              Container(
                height: 50,
                width: screenWidth - 32, // Adjusted width
                decoration: BoxDecoration(
                  color: Color.fromRGBO(160, 28, 201, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    DateFormat('d MMMM yyyy').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Statistics with Bar Graph
              Text(
                'Statistics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildProgressBar('Push-up', ((pushUpCount / 30).clamp(0.0, 1.0)),
                  GFColors.DANGER),
              SizedBox(height: 10),
              _buildProgressBar('Sit-ups', ((sitUpCount / 30).clamp(0.0, 1.0)),
                  GFColors.INFO),

              SizedBox(height: 50),

              // Fitness Information
              Text(
                'Fitness Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildListTile('Push-Up', '$pushUpCount time', 'pushup.png'),
              _buildListTile('Sit-Up', '$sitUpCount time', 'sit-up.png'),
              _buildListTile('Calories', '$globaltotalCalories calories today',
                  'calories.png'),
              _buildListTile(
                  'Water', '$waterCount glasse', 'glass-of-water.png'),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      waterCount = 0;
                      pushUpCount = 0;
                      sitUpCount = 0;
                      globaltotalCalories = 0;
                      pushUpHistory = [];
                      sitUpHistory = [];
                      selectedFoodItems = [];
                    });
                  },
                  child: Text('Clean'))
            ],
          ),
        ),
      ),
      bottomNavigationBar: CusBottomBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildProgressBar(
      String label, double percentage, Color progressBarColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        GFProgressBar(
          percentage: percentage,
          backgroundColor: Colors.black26,
          progressBarColor: progressBarColor,
          lineHeight: 20,
          leading: Icon(Icons.sentiment_dissatisfied, color: GFColors.DANGER),
          trailing: Icon(Icons.sentiment_satisfied, color: GFColors.SUCCESS),
          alignment: MainAxisAlignment.spaceBetween,
          child: Text(
            '${(percentage * 100).toStringAsFixed(0)}%',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildListTile(String title, String subtitle, String leadingImage) {
    return ListTile(
      leading: Image.asset('${_imagePath}$leadingImage'),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
