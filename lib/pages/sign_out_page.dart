import 'package:firebase_auth/firebase_auth.dart';
import 'package:university_helper/auth_dart.dart';
import 'package:flutter/material.dart';
import 'package:university_helper/pages/exams_page.dart';

class SignOutPage extends StatelessWidget {
  SignOutPage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(context),
          ],
        ),
      ),
    );
  }
}