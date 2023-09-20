import 'package:flutter/material.dart';
import 'package:vruksha/Activity/Post/PostDesc.dart';
import 'package:vruksha/Cards/expert_postcard.dart';

class Home extends StatelessWidget {
  final diseaseName = 'HI';
  final date = '11.11.2004';
  // Sample list of post data (you can replace this with your data)

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
