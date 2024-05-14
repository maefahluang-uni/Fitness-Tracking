import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maincode/componant/bottombar.dart';
import 'package:maincode/componant/globals.dart';

// Define global variables
class FoodItem {
  final String name;
  final int calories;

  FoodItem({required this.name, required this.calories});
}

class FoodSummaryPage extends StatefulWidget {
  const FoodSummaryPage({Key? key}) : super(key: key);

  @override
  _FoodSummaryPageState createState() => _FoodSummaryPageState();
}

class _FoodSummaryPageState extends State<FoodSummaryPage> {
  int totalCalories = globaltotalCalories;
  // List<FoodItem> selectedFoodItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracking'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserDetails(),
            SizedBox(height: 16.0),
            // _buildCalendarBar(),
            // SizedBox(height: 16.0),
            _buildFoodList(),
            SizedBox(height: 16.0),
            _buildNutritionalInformation(),
            SizedBox(height: 16.0),
            _buildWaterIntake(),
            SizedBox(height: 80.0),
          ],
        ),
      ),
      bottomNavigationBar: CusBottomBar(
        currentIndex: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFoodSelectionDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildUserDetails() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.photoURL != null
              ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
              : AssetImage('assets/userprofile.png') as ImageProvider<Object>?,
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
    );
  }

  // Widget _buildCalendarBar() {
  //   return Container(
  //     color: Colors.blue, // Background color for the whole calendar
  //     child: Table(
  //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  //       children: [
  //         TableRow(
  //           children: List.generate(
  //             7,
  //             (index) => TableCell(
  //               child: Container(
  //                 color: Colors.white, // Background color for each day
  //                 child: Center(
  //                   child: Text(
  //                     '${index + 1}',
  //                     style: TextStyle(
  //                       color: Colors.black, // Text color for each day
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         TableRow(
  //           children: List.generate(
  //             7,
  //             (index) => TableCell(
  //               child: Container(
  //                 color: Colors.white, // Background color for each day
  //                 child: Center(
  //                   child: Text(
  //                     'Mar',
  //                     style: TextStyle(
  //                       color: Colors.black, // Text color for each day
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         TableRow(
  //           children: List.generate(
  //             7,
  //             (index) => TableCell(
  //               child: Container(
  //                 color: Colors.white, // Background color for each day
  //                 child: Center(
  //                   child: Text(
  //                     '2024',
  //                     style: TextStyle(
  //                       color: Colors.black, // Text color for each day
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFoodList() {
    if (selectedFoodItems.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No food items selected. Tap the + button to add food.',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: selectedFoodItems.length,
          itemBuilder: (context, index) {
            return _buildFoodItem(selectedFoodItems[index].name,
                '${selectedFoodItems[index].calories} cal', index);
          },
        ),
      );
    }
  }

  Widget _buildFoodItem(String foodName, String calories, int index) {
    return ListTile(
      title: Text(
        foodName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(calories),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: () {
          setState(() {
            selectedFoodItems.removeAt(index);
          });
        },
      ),
    );
  }

  Widget _buildNutritionalInformation() {
    globaltotalCalories = selectedFoodItems.fold(
        0, (previousValue, element) => previousValue + element.calories);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutritional Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 8.0),
        _buildNutrientInfo('Total Calories', '$globaltotalCalories kcal'),
      ],
    );
  }

  Widget _buildNutrientInfo(String nutrient, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        '$nutrient: $value',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildWaterIntake() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Water Intake',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 8.0),
        _buildWaterCounter(),
      ],
    );
  }

  Widget _buildWaterCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Implement logic to decrease water count
            setState(() {
              if (waterCount > 0) {
                waterCount--;
              }
            });
          },
          child: Icon(
            Icons.remove,
            size: 30,
            color: Colors.blue,
          ),
        ),
        Text(
          '$waterCount glasses',
          style: TextStyle(fontSize: 16.0),
        ),
        Icon(
          Icons.water_drop,
          size: 30,
          color: Color.fromARGB(255, 58, 56, 221),
        ),
        GestureDetector(
          onTap: () {
            // Implement logic to increase water count
            setState(() {
              waterCount++;
            });
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  void _showFoodSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Food Item'),
          content: SingleChildScrollView(
            child: Column(
              children: availableFoodItems
                  .map((foodItem) => ListTile(
                        title: Text(foodItem.name),
                        subtitle: Text('${foodItem.calories} cal'),
                        onTap: () {
                          setState(() {
                            selectedFoodItems.add(foodItem);
                          });
                          Navigator.pop(context);
                        },
                      ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
