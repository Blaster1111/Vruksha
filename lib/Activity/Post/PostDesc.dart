import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vruksha/Cards/comment_card.dart';
import 'package:vruksha/Cards/expert_postcard.dart';

class PostViewPage extends StatefulWidget {
  final String diseaseName;
  final String date;
  final String imageUrl;

  PostViewPage({
    required this.diseaseName,
    required this.date,
    required this.imageUrl,
  });

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  final TextEditingController _commentController = TextEditingController();

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
                date: '${widget.date}',
                diseaseName: '${widget.diseaseName}',
                imageUrl: '${widget.imageUrl}',
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
            Center(
              child: Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400),
                    onPressed: () {},
                    child: Text(
                      'Verify as Expert',
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )),
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
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'Add a comment...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      String commentMessage = _commentController.text;

                      if (commentMessage.isNotEmpty) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String authToken = prefs.getString('authToken') ?? '';

                        String apiUrl = '';
                        Map<String, dynamic> body = {
                          'message': commentMessage,
                          'date': authToken,
                        };
                      }
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
          ],
        ),
      ),
    );
  }
}
