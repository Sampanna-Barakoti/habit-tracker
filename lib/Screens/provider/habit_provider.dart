import 'package:flutter/material.dart';
import 'package:habit_tracker/Model/habit_model.dart';

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];
  List<Habit> get habit => _habits;
  int get totalHabit => _habits.length;

  //getter to calc how many habot have been completed
  int get completedHabits => _habits.where((habit) => habit.isCompleted).length;

  // calc the percentage
  double get completionPercentage {
    if (totalHabit == 0) return 0;
    return (completedHabits / totalHabit) * 100;
  }

  void addHabit(String title) {
    final newHabit = Habit(id: DateTime.now().toString(), title: title);
    _habits.add(newHabit);
    notifyListeners();
  }

  // method to toggle

  void toggleHabit(String id) {
    final index = _habits.indexWhere((habit) => habit.id == id);
    if (index != 1) {
      _habits[index].isCompleted = !habit[index].isCompleted;
      notifyListeners();
    }
  }
}
