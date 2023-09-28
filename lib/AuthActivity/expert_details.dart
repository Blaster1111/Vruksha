import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:vruksha/home_page.dart';

class ExpertDetails extends StatefulWidget {
  const ExpertDetails({super.key});

  @override
  State<ExpertDetails> createState() => _ExpertDetailsState();
}

class _ExpertDetailsState extends State<ExpertDetails> {
  final _nameController = TextEditingController();
  final _expController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _emailController = TextEditingController();
  final _aadharController = TextEditingController();
  final _expertiseController = TextEditingController();

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(validateForm);
    _expController.addListener(validateForm);
    _qualificationController.addListener(validateForm);
    _emailController.addListener(validateForm);
    _aadharController.addListener(validateForm);
    _expertiseController.addListener(validateForm);
  }

  void validateForm() {
    setState(() {
      isFormValid = _nameController.text.isNotEmpty &&
          _expController.text.isNotEmpty &&
          _qualificationController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _aadharController.text.isNotEmpty &&
          _expertiseController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _expController.dispose();
    _qualificationController.dispose();
    _emailController.dispose();
    _aadharController.dispose();
    _expertiseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Expert Verification",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildCircularTextField(_nameController, "Name"),
                SizedBox(height: 10.0),
                _buildCircularTextField(_expController, "Years of Experience"),
                SizedBox(height: 10.0),
                _buildCircularTextField(
                    _qualificationController, "Qualification"),
                SizedBox(height: 10.0),
                _buildCircularTextField(_emailController, "Email"),
                SizedBox(height: 10.0),
                _buildCircularTextField(_aadharController, "Aadhar Number"),
                SizedBox(height: 10.0),
                _buildCircularTextField(_expertiseController, "Expertise"),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: isFormValid
                      ? () async {
                          String name = _nameController.text;
                          String exp = _expController.text;
                          String qualification = _qualificationController.text;
                          String email = _emailController.text;
                          String aadhar = _aadharController.text;
                          String expertise = _expertiseController.text;

                          // Prepare the data for the API request.
                          String apiUrl =
                              'https://vrukshaa-server.onrender.com/auth/verify';
                          Map<String, dynamic> body = {
                            'name': name,
                            'qualification': qualification,
                            'email': email,
                            'experience': exp,
                            'aadhar number': aadhar,
                            'expertise': expertise,
                            'date': DateTime.now().toIso8601String(),
                          };

                          // Get the authToken from SharedPreferences.
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String authToken = prefs.getString('authToken') ?? '';

                          // Set the headers for the API request.
                          Map<String, String> headers = {
                            'Content-Type': 'application/json',
                            'authToken': authToken,
                          };

                          try {
                            // Send a POST request to the API.
                            http.Response response = await http.post(
                              Uri.parse(apiUrl),
                              headers: headers,
                              body: jsonEncode(body),
                            );

                            if (response.statusCode == 200) {
                              // If the API request is successful, set type=expert in SharedPreferences.
                              prefs.setString('type', 'expert');

                              // Navigate to the HomePage.
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(),
                                ),
                              );
                            } else {
                              print(
                                  'API request failed with status code: ${response.statusCode}');
                            }
                          } catch (e) {
                            print("Error verifying details: $e");
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                  ),
                  child: Text("Verify Details"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularTextField(
      TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
    );
  }
}
