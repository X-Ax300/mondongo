import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/timer_model.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerListPage extends StatefulWidget {
  @override
  _TimerListPageState createState() => _TimerListPageState();
}

class _TimerListPageState extends State<TimerListPage> {
  final box = Hive.box<TimerModel>('timers');
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('All Timers'),
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<TimerModel> box, _) {
          final timers = box.values.toList()
            ..sort((a, b) => a.endTime.compareTo(b.endTime));

          return ListView.builder(
            itemCount: timers.length,
            itemBuilder: (context, index) {
              final timer = timers[index];
              return _buildTimerTile(timer);
            },
          );
        },
      ),
    );
  }

  Widget _buildTimerTile(TimerModel timer) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 1), (count) {
        final remaining = timer.endTime.difference(DateTime.now()).inSeconds;
        if (remaining == 30) {
          _playAlert(timer.title, remaining);
        }
        return remaining;
      }),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data! <= 0) {
          return ListTile(
            title: Text(
              timer.title,
              style: const TextStyle(color: Colors.deepOrangeAccent),
            ),
            subtitle: const Text(
              'Time left: 00:00:00',
              style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.deepOrangeAccent),
              onPressed: () {
                timer.delete();
              },
            ),
          );
        } else {
          final remainingTime = snapshot.data!;
          final hours = (remainingTime ~/ 3600).toString().padLeft(2, '0');
          final minutes = ((remainingTime % 3600) ~/ 60).toString().padLeft(2, '0');
          final seconds = (remainingTime % 60).toString().padLeft(2, '0');
          return ListTile(
            title: Text(
              timer.title,
              style: const TextStyle(color: Colors.deepOrangeAccent),
            ),
            subtitle: Text(
              'Time left: $hours:$minutes:$seconds',
              style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.deepOrangeAccent),
              onPressed: () {
                timer.delete();
              },
            ),
          );
        }
      },
    );
  }

  void _playAlert(String title, int remainingSeconds) async {
    // Reproducir sonido de alerta desde los activos
    await _audioPlayer.play('assets/alert_sound.mp3');

    // Mostrar pop-up de alerta
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Time Alert'),
          content: Text('$title has $remainingSeconds seconds left!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
