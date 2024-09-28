import 'package:flutter/material.dart';

class TimePickerBottomSheet extends StatefulWidget {
  @override
  _TimePickerBottomSheetState createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  TimeOfDay? _selectedTime = TimeOfDay.now();

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        setState(() {
          _selectedTime = time;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _selectedTime == null
                  ? Text('No time selected')
                  : Text('Selected time: ${_selectedTime!.format(context)}'),
            ),
          ),
          MaterialButton(
            child: Text('Select Time'),
            onPressed: _showTimePicker,
          ),
          MaterialButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.pop(context, _selectedTime);
            },
          ),
        ],
      ),
    );
  }
}