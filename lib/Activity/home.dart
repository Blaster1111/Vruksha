import 'package:flutter/material.dart';
import 'package:vruksha/Activity/Post/PostDesc.dart';
import 'package:vruksha/Cards/expert_postcard.dart';

class Home extends StatelessWidget {
  final diseaseName = 'HI';
  final date = '11.11.2004';
  // Sample list of post data (you can replace this with your data)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade400, // Customize the background color
        flexibleSpace: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vruksha_icon.png', // Replace with your image path
                width: 40, // Adjust the width as needed
                height: 40, // Adjust the height as needed
              ),
              SizedBox(
                  width: 8.0), // Add some spacing between the image and text
              Text(
                'Vrukshaa',
                style: TextStyle(
                  fontSize: 20.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Add bold style if desired
                  color: Colors.white, // Customize the text color
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount:
            1, // Set the itemCount to the number of items you want to display
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = 'assets/images/Trial.jpg';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostViewPage(
                    diseaseName: diseaseName,
                    date: date,
                  ), // Pass data to PostDescPage
                ),
              );
            },
            child: PostCard(
              diseaseName: diseaseName,
              date: date,
              imageUrl: imageUrl,
            ),
          );
        },
      ),
    );
  }
}
