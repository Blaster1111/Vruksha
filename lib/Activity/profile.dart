import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vruksha/AuthActivity/Google_SignIn/auth_services.dart';
import 'package:vruksha/AuthActivity/welcome.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('ProfilePage'),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Sign out successful, you can now navigate to another screen or update the UI as needed.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WelcomePage(),
                    ),
                  );
                  print('User signed out');
                } catch (e) {
                  print('Error signing out: $e');
                }
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
