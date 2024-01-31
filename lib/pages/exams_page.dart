import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_helper/modules/exam.dart';
import 'package:university_helper/pages/login_register_page.dart';
import 'package:university_helper/pages/new_exam_page.dart';
import 'package:university_helper/pages/sign_out_page.dart';


class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  final List<Exam> _exams = [];

  String? errorMessage = '';

  Future _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ExamsPage()));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void _addExamFunction(){
    showModalBottomSheet(context: context, builder: (_) {
      return GestureDetector(onTap: (){},
        behavior: HitTestBehavior.opaque,
        child: NewExam(addExam: _addNewExamToList,),
      );
    });
  }

  _addNewExamToList(Exam exam) {
    setState(() {
      _exams.add(exam);
    });
  }

  @override
  Widget build(BuildContext context) {
    var isSignedIn = FirebaseAuth.instance.currentUser != null;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Exams',  style: TextStyle(color: Colors.white)), actions: [
          if (isSignedIn) ...[
            IconButton(
              icon: const Icon(Icons.add_circle),
              color: Colors.white,
              onPressed: _addExamFunction,
            ),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text("Sign out"),
            )
          ] else ...[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text("Sign in"),
            ),
          ]
        ]),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemCount: _exams.length,
          itemBuilder: (context, index){
              return Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [ ListTile(
                      title: Text(_exams[index].subject,
                        style:
                        TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,),
                      textAlign: TextAlign.center,),
                      subtitle: Text('${_exams[index].date.toLocal()}'.split('.')[0],
                        style:
                        TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,),
                    ),
                    IconButton(icon: Icon(Icons.delete_rounded), onPressed: () {
                        setState(() {
                          _exams.removeAt(index);
                        });
                      },)
                    ]),
                decoration:
                  BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12.0)),
                  margin: EdgeInsets.all(10.0),
              );
            }
        )
    );
  }
}
