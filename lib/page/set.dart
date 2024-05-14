import 'package:flutter/material.dart';
import 'package:maincode/componant/bottombar.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App'),
      ),
      body: Center(
        child: Text('Your content goes here'),
      ),
      bottomNavigationBar: CusBottomBar(currentIndex: 0,)
    );
  }
}
