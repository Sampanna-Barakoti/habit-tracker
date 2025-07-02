import 'package:flutter/material.dart';
import 'package:habit_tracker/Screens/provider/habit_provider.dart';
import 'package:provider/provider.dart';

class HomeList extends StatelessWidget {
  const HomeList({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Traker'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<HabitProvider>(context, listen: false).resetHabit();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily Progress: ${habitProvider.completedHabits}/${habitProvider.totalHabit} Habit Completed",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value:
                      habitProvider.totalHabit > 0
                          ? habitProvider.completionPercentage /
                              habitProvider.totalHabit
                          : 0,
                ),
                SizedBox(height: 8),
                Text(
                  "Completed Percentages: ${habitProvider.completionPercentage.toStringAsFixed(1)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Habit list section
          Expanded(
            child: ListView.builder(
              itemCount: habitProvider.habit.length,
              itemBuilder: (context, index) {
                final habit = habitProvider.habit[index];

                return GestureDetector(
                  onLongPress: () => habitProvider.removeHabit(habit.id),
                  child: ListTile(
                    title: Text(habit.title),
                    trailing: Checkbox(
                      value: habit.isCompleted,
                      onChanged: (_) {
                        habitProvider.toggleHabit(habit.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,

            builder: (ctx) {
              String newHabitTitle = '';
              return AlertDialog(
                title: Text('Add Habit'),
                content: TextField(
                  onChanged: (value) {
                    newHabitTitle = value;
                  },
                  decoration: InputDecoration(hintText: 'Habit Title'),
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newHabitTitle.isNotEmpty) {
                        habitProvider.addHabit(newHabitTitle);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
