import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(SportTrackerApp());
}

class SportTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WorkoutScreen(),
    );
  }
}

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<String> workouts = [];
  TextEditingController workoutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  _loadWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      workouts = prefs.getStringList('workouts') ?? [];
    });
  }

  _addWorkout() async {
    if (workoutController.text.isEmpty) return;
    setState(() {
      workouts.add(workoutController.text);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('workouts', workouts);
    workoutController.clear();
  }

  _shareResults() {
    String message = "Мои тренировки: ${workouts.join(', ')}! 🏋️‍♂️🔥";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Тренировки')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: workoutController,
              decoration: InputDecoration(labelText: 'Новая тренировка'),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _addWorkout, child: Text('Добавить')),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(workouts[index]),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: _shareResults, child: Text('Поделиться')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengeScreen()),
                );
              },
              child: Text('Челленджи'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeScreen extends StatelessWidget {
  final List<String> challenges = [
    '30 приседаний в день',
    '5 км бега',
    '100 отжиманий в неделю'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Челленджи')),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(challenges[index]));
        },
      ),
    );
  }
}
