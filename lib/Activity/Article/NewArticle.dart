import 'package:flutter/material.dart';
import 'package:vruksha/Activity/Article/ArticleView.dart';

class NewArticle extends StatelessWidget {
  const NewArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(children: [
            Text(
              'Title of Article',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                  color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0025,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Title of Article:',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                maxLines: null,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0025,
            ),
            Text(
              'Description',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                  color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0025,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Content of your Article:',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                maxLines: null,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0255,
            ),
            Text(
              'Tags',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                  color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0025,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter relevant Texts:',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                maxLines: null,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0025,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ArticleViewCard(
                              articleTitle: 'Article Title',
                              date: '11.11.11',
                              tags: ['Rudra', 'Shukla'],
                              articleContent: 'Hi my name is albama i am dumb',
                              likes: 11,
                              userName: 'Rudra')));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade400),
                child: Text(
                  'Publish Article',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
