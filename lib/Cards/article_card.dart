import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final String articleTitle;
  final String articleDesc;
  final String date;
  final String expertName;

  ArticleCard({
    required this.articleTitle,
    required this.articleDesc,
    required this.date,
    required this.expertName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16.0),
      color: Colors.amber.shade300,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                articleTitle,
                style: TextStyle(
                  fontSize: 16.0,
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
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            articleDesc,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Spacer(),
              Text(
                expertName,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
