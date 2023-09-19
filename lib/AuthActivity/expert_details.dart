import 'package:flutter/material.dart';

class ExpertDetails extends StatefulWidget {
  const ExpertDetails({super.key});

  @override
  State<ExpertDetails> createState() => _ExpertDetailsState();
}

class _ExpertDetailsState extends State<ExpertDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade300, // Set the background color here
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
                _buildCircularTextField("Name"),
                SizedBox(height: 10.0),
                _buildCircularTextField("Years of Experience"),
                SizedBox(height: 10.0),
                _buildCircularTextField("Qualification"),
                SizedBox(height: 10.0),
                _buildCircularTextField("Email"),
                SizedBox(height: 10.0),
                _buildCircularTextField("Aadhar Number"),
                SizedBox(height: 10.0),
                _buildCircularTextField("Expertise"),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle verification logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green.shade400, // Set the button color here
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

  Widget _buildCircularTextField(String labelText) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
    );
  }
}
