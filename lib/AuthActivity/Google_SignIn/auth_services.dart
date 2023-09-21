import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vruksha/AuthActivity/welcome.dart';
import 'package:vruksha/home_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> hangleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);

        // After Firebase authentication is successful, prepare data for the API.
        String apiUrl = 'https://vruksha-server.onrender.com/auth/';
        Map<String, dynamic> body = {
          'uid': _auth.currentUser?.uid,
          'providerData': _auth.currentUser?.providerData.toString(),
          'date': DateTime.now().toIso8601String(),
        };
        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };

        // Send a POST request to the API.
        http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          // If the API request is successful, parse the response.
          Map<String, dynamic> responseData = jsonDecode(response.body);
          String authToken = responseData['authToken'];

          // Store the authToken in SharedPreferences for future use.
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', authToken);

          // Navigate to the HomePage.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          print('API request failed with status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print("error signing in: $e");
    }
  }

  Future<void> handleSignOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    } catch (e) {
      print("error signing out: $e");
    }
  }
}
