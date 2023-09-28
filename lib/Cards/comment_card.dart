import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String description;
  final String date;
  final int likeCount;
  final bool isLiked;
  final VoidCallback onLikePressed;

  CommentCard({
    required this.description,
    required this.date,
    required this.likeCount,
    required this.isLiked,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      color: Colors.grey.shade400,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.thumb_up : Icons.thumb_up_alt,
                    color: isLiked ? Colors.blue : Colors.black,
                  ),
                  onPressed: onLikePressed,
                ),
                Text(
                  '${likeCount} found this helpful',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
