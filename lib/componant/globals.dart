import 'package:maincode/page/foodsummary.dart';
int waterCount = 0;
int pushUpCount = 0;
int sitUpCount = 0;
int globaltotalCalories = 0;
List<String> pushUpHistory = [];
List<String> sitUpHistory = [];
List<FoodItem> selectedFoodItems = [];
  List<FoodItem> availableFoodItems = [
    FoodItem(name: 'Healthy Breakfast', calories: 120),
    FoodItem(name: 'Fast Food', calories: 500),
    FoodItem(name: 'Fruit', calories: 80),
    FoodItem(name: 'Salad', calories: 200),
    FoodItem(name: 'Smoothie', calories: 150),
    FoodItem(name: 'Snacks', calories: 300),
    FoodItem(name: 'Dinner', calories: 400),
  ];