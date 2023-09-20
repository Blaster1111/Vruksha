import 'package:flutter/material.dart';
import 'package:vruksha/Activity/articles.dart';
import 'package:vruksha/Activity/home.dart';
import 'package:vruksha/Activity/Post/posts.dart';
import 'package:vruksha/Activity/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    Home(),
    PostPage(),
    ArticlePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: Container(
        color: Colors.green.shade200,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded), label: 'Post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add), label: 'Article'),
            BottomNavigationBarItem(
                icon: Icon(Icons.note_outlined), label: 'Profile'),
          ],
          selectedItemColor: Colors.black,
          backgroundColor: Colors.green.shade200,
        ),
      ),
    );
  }
}
