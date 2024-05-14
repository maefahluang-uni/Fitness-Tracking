import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maincode/componant/bottombar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'), // Title
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: FirebaseAuth.instance.currentUser != null &&
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
                      FirebaseAuth.instance.currentUser!.displayName.toString(),
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
            SizedBox(height: 16),
            // Preference section
            _buildListTileWithBackground(
              title: 'Preference',
              onTap: () {
                // Handle navigation to preferences page
              },
            ),

            // Divider
            SizedBox(height: 16),

            // Edit Profile section
            _buildListTileWithBackground(
              icon: Icons.person,
              title: 'Edit Profile',
              onTap: () {
                // Handle navigation to edit profile page
                Navigator.pushNamed(context, '/editprofile');
              },
            ),

            // Divider
            SizedBox(height: 16),

            // Contacts section
            _buildListTileWithBackground(
              icon: Icons.contacts,
              title: 'Contacts',
              onTap: () {
                // Handle navigation to contacts page
                Navigator.pushNamed(context, '/contract');
              },
            ),

            // Divider
            SizedBox(height: 16),

            // Log Out section
            _buildListTileWithBackground(
              icon: Icons.logout,
              title: 'Log Out',
              onTap: () {
                // Handle logout functionality
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CusBottomBar(
        currentIndex: 3,
      ),
    );
  }

  Widget _buildListTileWithBackground(
      {IconData? icon, required String title, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(8), // Border radius
      ),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0), // Margin
      child: ListTile(
        leading: icon != null ? Icon(icon) : null, // Icon
        title: Text(title), // Title
        onTap: onTap, // onTap callback
      ),
    );
  }
}
