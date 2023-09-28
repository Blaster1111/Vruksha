import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vruksha/Cards/comment_card.dart';
import 'package:vruksha/Cards/expert_postcard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostViewPage extends StatefulWidget {
  final String diseaseName;
  final String date;
  final String imageUrl;
  final String desc;
  final String postId;

  PostViewPage({
    required this.diseaseName,
    required this.date,
    required this.imageUrl,
    required this.desc,
    required this.postId,
  });

  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  final TextEditingController _commentController = TextEditingController();
  int likesCount = 0;
  late bool userLiked;
  late List<String> likes1;
  late String userId;
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    GetLikes();
    getComments();
  }

  Future<List<dynamic>> getComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('authToken') ?? '';

    final response = await http.get(
      Uri.parse(
          'https://vrukshaa-server.onrender.com/post/comments/${widget.postId}'),
      headers: {
        'Content-type': 'application/json',
        'authToken': authToken,
      },
    );

    if (response.statusCode == 200) {
      final respData = jsonDecode(response.body);
      print('API Response: ${response.body}');
      return List<dynamic>.from(respData);
    } else {
      // Handle API error
      print('API Error - Status Code: ${response.statusCode}');
      print('API Response: ${response.body}');
      throw Exception('Failed to fetch comments');
    }
  }

  Future<Map<String, dynamic>> postComment(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('authToken') ?? '';

    final response = await http.post(
      Uri.parse(
          'https://vrukshaa-server.onrender.com/post/comments/${widget.postId}'),
      headers: {
        'Content-type': 'application/json',
        'authToken': authToken,
      },
      body: jsonEncode({'message': data['message']}),
    );
    print('API Response: ${response.statusCode} - ${response.body}');
    final respData = jsonDecode(response.body);
    return respData;
  }

  Future<void> UnlikesBackend(userId) async {
    final url2 =
        "https://vrukshaa-server.onrender.com/post/unlike/${widget.postId}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('authToken') ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authToken': authToken,
    };
    try {
      final response = await http.patch(
        Uri.parse(url2),
        headers: headers,
      );

      if (response.statusCode == 200) {
        setState(() {
          likesCount--;
        });

        final respData = jsonDecode(response.body);
        print('Response from like API: $respData');
        return respData;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> GetLikes() async {
    final url1 =
        "https://vrukshaa-server.onrender.com/post/like/${widget.postId}";
    print(url1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('authToken') ?? '';
    userId = prefs.getString('userId') ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authToken': authToken,
    };

    try {
      final response = await http.patch(
        Uri.parse(url1),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final respData = jsonDecode(response.body);
        print('Response from API: $respData');
        likes1 = List<String>.from(respData['likes']);
        userLiked = likes1.contains(userId);

        setState(() {
          likesCount = likes1.length;
        });
      } else {
        print(
            'Failed to fetch post likes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Network error: $e');
    }
  }

  Future<void> LikePost() async {
    userLiked = likes1.contains(userId);

    likesCount = likes1.length;
    if (userLiked) {
      // User has already liked, so perform unlike
      likes1.remove(userId);
      await UnlikesBackend(userId);
    } else {
      likes1.add(userId);
      // User hasn't liked, so perform like
      final url1 =
          "https://vrukshaa-server.onrender.com/post/like/${widget.postId}";

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String authToken = prefs.getString('authToken') ?? '';

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'authToken': authToken,
      };

      try {
        final response = await http.patch(
          Uri.parse(url1),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final respData = jsonDecode(response.body);
          print('Response from like API: $respData');

          setState(() {
            likesCount++;
          });
          return respData;
        } else {
          throw Exception('Failed to like post');
        }
      } catch (e) {
        print('Status code error');
      }
    }
  }

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
                widget.imageUrl,
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
                        onPressed: () async {
                          LikePost();
                        },
                      ),
                      SizedBox(width: 8.0),
                      Text('$likesCount Found Useful'),
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
                      final message = _commentController.text;

                      if (message.isNotEmpty) {
                        await postComment({'message': message});

                        setState(() {
                          _commentController.clear();
                          getComments();
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Comment Error'),
                              content: Text(
                                'Failed to post the comment. Please try again.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  FutureBuilder<List<dynamic>>(
                    future: getComments(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While fetching comments, display a loading indicator
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Handle errors
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        // Handle case when there are no comments
                        return Text('No comments available.');
                      } else {
                        // Display comments using ListView.builder
                        final comments = snapshot.data as List<dynamic>;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment =
                                comments[index] as Map<String, dynamic>;
                            final message = comment['message'];
                            final createdAt = comment['createdAt'];
                            final likes = comment['likes'] as List<dynamic>;
                            final likesCount = likes.length;

                            return CommentCard(
                              description: message,
                              date: createdAt,
                              likeCount: likesCount,
                              // Add other properties like isLiked as needed
                              onLikePressed: () {},
                              isLiked:
                                  false, // Assuming you need to determine if the user has liked the comment
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
