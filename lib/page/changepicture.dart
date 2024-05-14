import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPicturePage extends StatefulWidget {
  const EditPicturePage({Key? key});

  @override
  State<EditPicturePage> createState() => _EditPicturePageState();
}

class _EditPicturePageState extends State<EditPicturePage> {
  File? _imageFile;
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    File? imageFile = _imageFile;

    // Upload image to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);

    // Wait for the upload to complete
    await uploadTask.whenComplete(() => print('Image uploaded'));

    // Get the download URL
    String imageURL = await firebaseStorageRef.getDownloadURL();

    // Do something with the imageURL, such as saving it to the user's profile
    print('Image URL: $imageURL');
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageURL);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: ListView(children: [
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        )
                      : Placeholder(
                          fallbackHeight: 200,
                          fallbackWidth: 200,
                        ),
                ),
                SizedBox(height: 4),
                ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Pick Image from Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.purple,
                          Color.fromARGB(255, 215, 68, 238)
                        ]),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              blurRadius: 5,
                              offset: Offset(3, 3),
                              spreadRadius: 3)
                        ]),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.transparent,
                        disabledForegroundColor:
                            Colors.transparent.withOpacity(0.38),
                        disabledBackgroundColor:
                            Colors.transparent.withOpacity(0.12),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        if (_imageFile != null) {
                          uploadImage();
                          Navigator.pushNamed(context, '/home');
                        } else {
                          // Handle case where _imageFile is null
                          print('No image selected');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Confirm',
                              style: TextStyle(
                                  color: const Color.fromARGB(
                                      255, 255, 255, 255))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
