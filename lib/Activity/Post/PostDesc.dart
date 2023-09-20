import 'package:flutter/material.dart';
import 'package:vruksha/Cards/comment_card.dart';
import 'package:vruksha/Cards/expert_postcard.dart';

class PostViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: PostCard(
                date: 'Date',
                diseaseName: 'Dieae name',
                imageUrl: 'assets/images/Trial.jpg',
              ),
            ),

            Container(
              color: Colors.green.shade600,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Problem Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              color: Colors.green.shade400,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Solution: Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {
                          // Handle like button press
                        },
                      ),
                      SizedBox(width: 8.0),
                      Text('15 Found Useful'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.comment),
                      SizedBox(width: 8.0),
                      Text('5 Comments'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Add a comment...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Handle sending the comment
                    },
                  ),
                ],
              ),
            ),
            CommentCard(
              description: 'This is a comment.',
              date: '2 hours ago',
              likeCount: 5,
              isLiked: false,
              onLikePressed: () {
                // Handle like button press
              },
            ),
            CommentCard(
              description: 'Another comment here.',
              date: '1 day ago',
              likeCount: 10,
              isLiked: true,
              onLikePressed: () {},
            ),
            // Add more CommentCard widgets for additional comments
          ],
        ),
      ),
    );
  }
}
