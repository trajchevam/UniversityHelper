import 'package:flutter/material.dart';
import 'exam.dart';

class ExamProvider extends ChangeNotifier {
  List<Exam> _exams = [];

  List<Exam> get exams => _exams;

  void addExam(Exam exam) {
    _exams.add(exam);
    notifyListeners();
  }

  void deleteExam(Exam exam) {
    _exams.remove(exam);
    notifyListeners();
  }

  void editExam(int index, Exam updatedExam) {
    if (index >= 0 && index < _exams.length) {
      _exams[index] = updatedExam;
      notifyListeners();
    }
  }

  void takeExams(List<Exam> exams){
    _exams = exams;
  }
}
