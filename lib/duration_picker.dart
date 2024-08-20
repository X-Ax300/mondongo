import 'package:flutter/material.dart';

Future<Duration?> showDurationPicker({
  required BuildContext context,
  required Duration initialTime,
}) {
  return showModalBottomSheet<Duration>(
    context: context,
    backgroundColor: Colors.black,
    builder: (BuildContext context) {
      Duration selectedDuration = initialTime;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Duration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _durationButton(
                      context: context,
                      icon: Icons.remove,
                      onPressed: () {
                        setState(() {
                          if (selectedDuration.inSeconds > 0) {
                            selectedDuration -= const Duration(seconds: 1);
                          }
                        });
                      },
                    ),
                    Text(
                      '${selectedDuration.inMinutes}:${(selectedDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.cyanAccent,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                    _durationButton(
                      context: context,
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          selectedDuration += const Duration(seconds: 1);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context, selectedDuration);
                  },
                  child: const Text('Set Duration'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _durationButton({
  required BuildContext context,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return IconButton(
    icon: Icon(icon),
    color: Colors.cyanAccent,
    onPressed: onPressed,
  );
}
