import 'dart:math';
import 'package:flutter/material.dart';
import 'package:university_helper/services/notification_service.dart';
import '../modules/exam.dart';

class NewExam extends StatefulWidget {
  final Function addExam;

  const NewExam({super.key, required this.addExam});

  @override
  State<NewExam> createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {

  final _subjectController = TextEditingController();
  DateTime? _examDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      _presentTimePicker(pickedDate);
    });
  }

  void _presentTimePicker(DateTime pickedDate) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() {
        _examDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    });
  }

  void _submitData() {
    if (_subjectController.text.isEmpty) {
      return;
    }
    final enteredSubject = _subjectController.text;

    if (enteredSubject.isEmpty) {
      return;
    }

    final newExam = Exam(
      Random().nextInt(1000),
      enteredSubject,
      _examDate!,
    );

    widget.addExam(newExam);
    NotificationService.sendNotification(newExam);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const Text("Add new exam",
            style: TextStyle(fontSize: 20, color: Colors.lightBlueAccent)),
        TextField(
          controller: _subjectController,
          decoration: const InputDecoration(
            labelText: "Subject",
            hintText: "Subject",
          ),
          onSubmitted: (_) => _submitData,
        ),
        Row(
          children: <Widget>[
            if (_examDate == null)
              const Text(
                'Select time and date',
              ),
            if (_examDate != null)
              Expanded(
                child: Text(
                  'Selected: ${_examDate!.toLocal()}'.split('.')[0],
                ),
              ),
            TextButton(
              onPressed: _presentDatePicker,
              child: const Icon(Icons.date_range_outlined),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: _submitData,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: const Text("Submit"))
      ]),
    );
  }
}