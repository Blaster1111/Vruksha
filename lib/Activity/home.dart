import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vruksha/Activity/Post/PostDesc.dart';
import 'package:vruksha/Cards/expert_postcard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final diseaseName = 'HI';
  List<Map<String, dynamic>> postData = [];
  final date = '11.11.2004';

  @override
  void initState() {
    super.initState();
    fetchDataFromBackend();
  }

  Future<void> fetchDataFromBackend() async {
    final apiUrl = 'https://vruksha-server.onrender.com/post/';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('authToken') ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authToken': authToken,
    };
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      print(response);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          postData = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Req Failed in status code');
      }
    } catch (e) {
      print('Req Failed in url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade400, // Customize the background color
        flexibleSpace: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vruksha_icon.png', // Replace with your image path
                width: 40, // Adjust the width as needed
                height: 40, // Adjust the height as needed
              ),
              SizedBox(
                  width: 8.0), // Add some spacing between the image and text
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
      body: ListView.builder(
        itemCount: postData.length,
        itemBuilder: (BuildContext context, int index) {
          final post = postData[index];
          final imageUrl = post['img'] != null
              ? post['img']
              : 'https://example.com/default_image.jpg';
          final diseaseName = post['desc'] ?? 'Unknown Disease';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostViewPage(
                    imageUrl: imageUrl,
                    diseaseName: diseaseName,
                    date: '11.11.2004', // You can set the date as needed
                  ),
                ),
              );
            },
            child: PostCard(
              diseaseName: diseaseName,
              date: '11.11.2004',
              imageUrl: imageUrl,
            ),
          );
        },
      ),
    );
  }
}
