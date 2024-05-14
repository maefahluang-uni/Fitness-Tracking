import 'package:flutter/material.dart';
import 'package:maincode/componant/bottombar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactInformationPage(),
    );
  }
}

class ContactInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.purple[300]!,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Contact Us'),
                    _buildContactItem(
                      Icon(Icons.phone, size: 28, color: Colors.purple),
                      '+092xxx6947',
                    ),
                    _buildContactItem(
                      Icon(Icons.mail, size: 28, color: Colors.purple),
                      '6531503004@lamduan.mfu.ac.th',
                    ),
                    _buildContactItem(
                      Icon(Icons.location_on, size: 28, color: Colors.purple),
                      '123 Maple Street, Cityville, State,\n Zip Code \nInstagram: @samgreen123 ',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CusBottomBar(
        currentIndex: 3,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.purple[700],
        ),
      ),
    );
  }

  Widget _buildContactItem(Widget icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          icon,
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.purple[700],
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
