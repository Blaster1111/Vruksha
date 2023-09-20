import 'package:flutter/material.dart';
import 'package:vruksha/Cards/comment_card.dart';

class ArticleViewCard extends StatelessWidget {
  final String articleTitle;
  final String date;
  final List<String> tags;
  final String articleContent;
  final int likes;
  final String userName;

  ArticleViewCard({
    required this.articleTitle,
    required this.date,
    required this.tags,
    required this.articleContent,
    required this.likes,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16.0),
      color: Colors.amber.shade300,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  articleTitle,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: tags.map((tag) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber.shade400,
                    onPrimary: Colors.black,
                  ),
                  child: Text(tag),
                );
              }).toList(),
            ),
            SizedBox(height: 8.0),
            Text(
              articleContent,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    // Handle like button press
                  },
                ),
                Text(
                  '$likes people found this helpful',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Text(
              'By $userName',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
