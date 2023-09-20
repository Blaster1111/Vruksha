import 'package:flutter/material.dart';

import 'package:vruksha/Activity/Article/NewArticle.dart';
import 'package:vruksha/Cards/article_card.dart'; // Import your ArticleCard widget
import 'package:vruksha/Activity/Article/ArticleView.dart'; // Import your ArticleViewCard widget

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade400,
        flexibleSpace: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vruksha_icon.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8.0),
              Text(
                'Vrukshaa',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NewArticle()));
              // Handle button tap (you can add functionality here)
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400),
            icon: Icon(Icons.add), // Add the "+" icon
            label: Text('Add Article'), // Add button label
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  5, // Replace with the number of articles you want to display
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to ArticleViewCard when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ArticleViewCard(
                            articleTitle: 'Vruksa',
                            date: '11  ',
                            tags: ['Date', 'No'],
                            articleContent: 'articleConten',
                            likes: 69,
                            userName: 'Rudra'),
                      ),
                    );
                  },
                  child: ArticleCard(
                    // Pass article data to ArticleCard here
                    articleTitle: 'Sample Article $index',
                    articleDesc: 'Sample Description $index',
                    date: 'Sample Date $index',
                    expertName: 'Sample Expert $index',
                    // Add any other data you want to pass to ArticleCard
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
