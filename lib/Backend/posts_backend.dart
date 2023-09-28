import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String url = "https://vrukshaa-server.onrender.com/post/";

Future<Map<String, dynamic>> makePosts(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
    body: jsonEncode({'img': data['img'], 'description': data['description']}),
  );
  final respData = jsonDecode(response.body);
  return respData;
}

Future<Map<String, dynamic>> getPosts(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  final respData = jsonDecode(response.body);
  return respData;
}

Future<Map<String, dynamic>> getPost(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.get(
    Uri.parse('$url/find/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  final respData = jsonDecode(response.body);
  return respData;
}

Future<Map<String, dynamic>> likePost(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.patch(
    Uri.parse('$url/like/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  final respData = jsonDecode(response.body);
  return respData;
}

Future<Map<String, dynamic>> unlikePost(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.patch(
    Uri.parse('$url/unlike/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  final respData = jsonDecode(response.body);
  return respData;
}

Future<void> approvePost(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.patch(
    Uri.parse('$url/approve/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to approve the post');
  }
}

Future<void> disapprovePost(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.patch(
    Uri.parse('$url/disapprove/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to disapprove the post');
  }
}

Future<Map<String, dynamic>> getComments(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.get(
    Uri.parse('$url/comments/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
  );
  final respData = jsonDecode(response.body);
  return respData;
}

Future<Map<String, dynamic>> postComment(Map<String, dynamic> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString('authToken') ?? '';

  final response = await http.post(
    Uri.parse('$url/comments/${data['postId']}'),
    headers: {
      'Content-type': 'application/json',
      'authToken': authToken,
    },
    body: jsonEncode({'message': data['message']}),
  );
  final respData = jsonDecode(response.body);
  return respData;
}
