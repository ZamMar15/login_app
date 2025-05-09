import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter your email address'),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: emailController.text.trim());
                  messenger.showSnackBar(
                      SnackBar(content: Text('password reset email sent !')));
                } catch (e) {
                  messenger.showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')));
                }
              },
              child: Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}
