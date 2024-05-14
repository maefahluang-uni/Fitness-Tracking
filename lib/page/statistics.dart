import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maincode/componant/bottombar.dart';
import 'package:maincode/componant/globals.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String userName = "John Doe";
  String userEmail = "john.doe@example.com";
  String userImage = "assets/image.png"; // Replace with actual image path

  List<String> pushUpHistory = [];
  List<String> sitUpHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracking'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User details section
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
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
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

              // YouTube content section (Replace with actual YouTube content)
              Container(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/push-up.png'),
                    height: 200,
                  ),
                ),
              ),
              // Divider
              SizedBox(height: 16),

              // Push-up section
              Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Push-ups'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: $pushUpCount times'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Show dialog or navigate to a page for adding push-ups
                      // Add logic to update push-up count
                      setState(() {
                        pushUpCount += 1;
                        pushUpHistory.add('Push-up at ${DateTime.now()}');
                      });
                    },
                  ),
                ),
              ),

              // Divider
              SizedBox(height: 16),

              // Sit-up section
              Container(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/situps.png'),
                    height: 200,
                  ),
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Sit-ups'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total: $sitUpCount times'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // Show dialog or navigate to a page for adding sit-ups
                      // Add logic to update sit-up count
                      setState(() {
                        sitUpCount += 1;
                        sitUpHistory.add('Sit-up at ${DateTime.now()}');
                      });
                    },
                  ),
                ),
              ),

              // Divider
              SizedBox(height: 16),

              // History section
              Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Push-up History'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        pushUpHistory.map((entry) => Text(entry)).toList(),
                  ),
                ),
              ),

              // Divider
              SizedBox(height: 16),

              // History section
              Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Sit-up History'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: sitUpHistory.map((entry) => Text(entry)).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CusBottomBar(
        currentIndex: 2,
      ),
    );
  }
}
