import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vruksha/AuthActivity/Google_SignIn/auth_services.dart';
import 'package:vruksha/AuthActivity/welcome.dart';
import 'package:vruksha/Cards/expert_postcard.dart';
import 'package:vruksha/Activity/Post/PostDesc.dart';

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
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade400,
        flexibleSpace: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vruksha_icon.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8.0),
              Text(
                'Vrukshaa',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Your Past Diagnosis',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    5, // Replace with the number of items you want to display
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostViewPage(
                            imageUrl: '',
                            postId: '',
                            desc: '',
                            diseaseName: 'Sample Disease $index',
                            date: 'Sample Date $index',
                            // Pass any other data you need to the PostViewPage here
                          ),
                        ),
                      );
                    },
                    child: PostCard(
                      diseaseName: 'Sample Disease $index',
                      date: 'Sample Date $index',
                      imageUrl:
                          'assets/images/Trial.jpg', // Replace with your image path
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
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
