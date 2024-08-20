import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/timer_model.dart';
import 'screens/timer_creation_page.dart';
import 'screens/timer_list_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TimerModelAdapter());
  await Hive.openBox<TimerModel>('timers');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black, // Fondo negro para toda la app
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Fondo negro en la AppBar
          titleTextStyle: TextStyle(
            color: Colors.deepOrangeAccent, // Título de la AppBar en color cian
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.deepOrange,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrangeAccent, // Fondo cian para los botones
            foregroundColor: Colors.black, // Texto negro en los botones
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerCreationPage()),
                );
              },
              child: const Text('Create Timer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerListPage()),
                );
              },
              child: const Text('View Timers'),
            ),
          ],
        ),
      ),
    );
  }
}
