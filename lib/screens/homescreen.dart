import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/login_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Home Screen'),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              Text('Logged in as: ${user!.email}',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              if (user!.photoURL != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user!.photoURL!),
                ),
              const SizedBox(height: 20),
              Text('UID: ${user!.uid}',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
