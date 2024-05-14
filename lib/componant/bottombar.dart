import 'package:flutter/material.dart';
import 'package:maincode/page/foodsummary.dart';
import 'package:maincode/page/home.dart';
import 'package:maincode/page/setting.dart';
import 'package:maincode/page/statistics.dart';
import 'package:page_transition/page_transition.dart';

class CusBottomBar extends StatefulWidget {
  final int currentIndex;

  const CusBottomBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<CusBottomBar> createState() => _CusBottomBarState();
}

class _CusBottomBarState extends State<CusBottomBar> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        // Home
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: HomePage(), // Replace with your actual Home screen widget
          ),
        );
        break;
      case 1:
        // Project
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child:
                FoodSummaryPage(), // Replace with your actual Project screen widget
          ),
        );
        break;
      case 2:
        // Profile
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child:
                ActivityPage(), // Replace with your actual Profile screen widget
          ),
        );
        break;
      case 3:
        // Wallet
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child:
                SettingsPage(), // Replace with your actual Wallet screen widget
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Color.fromRGBO(160, 28, 201, 1),
      onTap: _onItemTapped,
      unselectedItemColor: Colors.grey,
    );
  }
}
