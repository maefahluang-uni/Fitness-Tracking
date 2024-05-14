import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maincode/componant/toast.dart';
import 'package:maincode/page/home.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Profile Picture
            CircleAvatar(
              radius: 60.0,
              backgroundImage: FirebaseAuth.instance.currentUser != null &&
                      FirebaseAuth.instance.currentUser!.photoURL != null
                  ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                  : AssetImage('assets/userprofile.png')
                      as ImageProvider<Object>?,
            ),
            SizedBox(height: 16.0),

            // Change Picture Button
            ElevatedButton(
              onPressed: () {
                // Implement change picture logic here
                // For simplicity, let's just print a message for now
                Navigator.pushNamed(context, '/changePicture');
              },
              child: Text('Change Picture'),
            ),
            SizedBox(height: 32.0),

            // Username Field
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Username',
                icon: Icon(Icons.person),
              ),
            ),
            // SizedBox(height: 16.0),

            // // Email Field
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Email',
            //     icon: Icon(Icons.email),
            //   ),
            // ),
            SizedBox(height: 32.0),

            // Update Button
            ElevatedButton(
              onPressed: () {
                // Implement update logic here
                // For simplicity, let's just print a message for now
                updateDisplayName();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void updateDisplayName() {
    FirebaseAuth.instance.currentUser!.updateDisplayName(_nameController.text);
    print('Update button pressed!');
    showToast(message: 'update success');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
