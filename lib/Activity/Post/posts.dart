import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vruksha/Activity/Post/PostDesc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String description = '';
  var _imageFile;
  bool isFormValid = false;

  Future<void> _requestCameraPermission() async {
    final PermissionStatus cameraStatus = await Permission.camera.request();
    final PermissionStatus galleryStatus = await Permission.photos.request();

    if (cameraStatus.isGranted || galleryStatus.isGranted) {
      _showImageSourceDialog();
    } else if (cameraStatus.isDenied || galleryStatus.isDenied) {
      print("Camera or gallery permission denied");
    } else if (cameraStatus.isPermanentlyDenied ||
        galleryStatus.isPermanentlyDenied) {
      print("Camera or gallery permission permanently denied");
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageToCloudinary() async {
    if (_imageFile != null) {
      final uri =
          Uri.parse("https://api.cloudinary.com/v1_1/db670bhmc/image/upload");
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'vruksha'
        ..files.add(http.MultipartFile(
          'file',
          _imageFile.readAsBytes().asStream(),
          _imageFile.lengthSync(),
          filename: 'image.jpg', // Change to the appropriate filename
        ));

      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          final responseJson = await response.stream.bytesToString();
          print('Image uploaded successfully!');
          print('Image URL: $responseJson');
          await sendToBackend(responseJson);
          Map<String, dynamic> imageUrlMap = json.decode(responseJson);
          String secureUrl = imageUrlMap["secure_url"];

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => PostViewPage(
                imageUrl: secureUrl,
                diseaseName: '',
                date: '',
                desc: description,
                postId: '',
              ),
            ),
          );
        } else {
          print('Failed to upload image. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
  }

  Future<void> sendToBackend(String imageUrl) async {
    const backendUrl = "https://vrukshaa-server.onrender.com/post/analysis";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String authToken = prefs.getString('authToken') ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authToken': authToken,
    };

    final data = {
      'img': imageUrl,
      'description': description,
    };

    final response = await http.post(
      Uri.parse(backendUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Data sent to backend successfully!');
      print('Response: ${response.body}');
    } else {
      print(
          'Failed to send data to backend. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
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
                  color: Colors.green.shade200,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'Add Image of your Diseased Crop',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                if (_imageFile == null)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: _requestCameraPermission,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade200,
                      ),
                      child: Icon(Icons.add),
                    ),
                  )
                else
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.file(_imageFile),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'Description:',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                      color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade200),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        description = value;
                        isFormValid =
                            _imageFile != null && description.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Description of your crop:',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    maxLines: null,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () async {
                            await _uploadImageToCloudinary();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isFormValid ? Colors.green.shade200 : Colors.red,
                      padding: EdgeInsets.all(16.0),
                    ),
                    child: Text(
                      'Send for Analysis',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
