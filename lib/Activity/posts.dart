import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vruksha/loading_analyis.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String description = '';
  var _imageFile;
  String _base64Image = "";
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
      _convertToBase64();
    }
  }

  void _convertToBase64() async {
    if (_imageFile != null) {
      List<int> imageBytes = await _imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);
      setState(() {
        _base64Image = base64String;
        isFormValid = _imageFile != null && description.isNotEmpty;
      });
      print("Base64 Image: $_base64Image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  height: MediaQuery.of(context).size.height * 0.3,
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
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Analysis_Loading(),
                            ),
                          );
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
    );
  }
}
