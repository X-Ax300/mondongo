import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/timer_model.dart';

class TimerCreationPage extends StatefulWidget {
  @override
  _TimerCreationPageState createState() => _TimerCreationPageState();
}

class _TimerCreationPageState extends State<TimerCreationPage> {
  final _titleController = TextEditingController();
  int _selectedHours = 0;
  int _selectedMinutes = 0;
  int _selectedSeconds = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Create Timer'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.deepOrangeAccent),
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.deepOrangeAccent),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPicker(
                    context: context,
                    itemCount: 24,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedHours = index;
                      });
                    },
                    label: "Hours",
                  ),
                  _buildPicker(
                    context: context,
                    itemCount: 60,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedMinutes = index;
                      });
                    },
                    label: "Minutes",
                  ),
                  _buildPicker(
                    context: context,
                    itemCount: 60,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedSeconds = index;
                      });
                    },
                    label: "Seconds",
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                final newTimer = TimerModel(
                  title: _titleController.text,
                  hours: _selectedHours,
                  minutes: _selectedMinutes,
                  seconds: _selectedSeconds,
                );
                final box = Hive.box<TimerModel>('timers');
                box.add(newTimer);
                Navigator.pop(context);
              },
              child: const Text('Add Timer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPicker({
    required BuildContext context,
    required int itemCount,
    required ValueChanged<int> onSelectedItemChanged,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
          ),
          Expanded(
            child: CupertinoPicker(
              backgroundColor: Colors.black,
              itemExtent: 40,
              onSelectedItemChanged: onSelectedItemChanged,
              children: List<Widget>.generate(itemCount, (index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
