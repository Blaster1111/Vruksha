import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vruksha/AuthActivity/expert.dart';
import 'package:vruksha/home_page.dart';

class OTPSignIn extends StatefulWidget {
  @override
  _OTPSignInState createState() => _OTPSignInState();
}

class _OTPSignInState extends State<OTPSignIn> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _verificationId = '';

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Handle successful login
      final isNewUser = authResult.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Expert()), // Navigate to Expert screen for new users
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage()), // Navigate to HomePage for existing users
        );
      }
      print('User signed in: ${authResult.user}');
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      // Handle verification failed
      print('Phone number verification failed: ${e.message}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verification Failed'),
            content: Text('Phone number verification failed: ${e.message}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    };

    final PhoneCodeSent codeSent = (String verificationId, int? resendToken) {
      // Store the verification ID for later use
      setState(() {
        _verificationId = verificationId;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('OTP Sent'),
            content: Text('OTP has been sent to your phone number.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto-retrieval timeout
      print('Auto-retrieval timeout: $verificationId');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> _signInWithOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final isNewUser = authResult.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Expert(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }

      print('User signed in: ${authResult.user}');

      // Extract user information
      final uid = authResult.user?.uid ?? '';
      final providerData = authResult.user?.providerData[0];
      final date = DateTime.now().toString();

      // Define API endpoint and headers
      final apiUrl = 'https://vruksha-server.onrender.com/auth/';
      final headers = {
        "Content-Type": "application/json",
      };

      // Create the request body
      final requestBody = {
        "uid": uid,
        "providerData": providerData,
        "date": date,
      };
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final authToken = responseData['authToken'];

        // Store the authToken in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', authToken);

        print('Auth token saved in SharedPreferences: $authToken');
      } else {
        print(
            'Failed to make the POST request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle verification failed
      print('Phone number verification failed: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verification Failed'),
            content: Text('Phone number verification failed: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final phoneNumber = '+91${_phoneNumberController.text}';
                _verifyPhoneNumber(phoneNumber);
              },
              child: Text('Send OTP'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final otp = _otpController.text.trim();
                _signInWithOTP(otp);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
