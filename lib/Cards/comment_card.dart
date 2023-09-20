import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
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
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
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
              widget.description,
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
                    widget.isLiked ? Icons.thumb_up : Icons.thumb_up_alt,
                    color: widget.isLiked ? Colors.blue : Colors.black,
                  ),
                  onPressed: widget.onLikePressed,
                ),
                Text(
                  '${widget.likeCount} people found this helpful',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.date}',
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
