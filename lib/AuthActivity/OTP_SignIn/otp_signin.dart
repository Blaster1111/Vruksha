import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vruksha/AuthActivity/expert.dart';
import 'package:vruksha/home_page.dart';

class OTPSignIn extends StatefulWidget {
  const OTPSignIn({Key? key}) : super(key: key);

  @override
  State<OTPSignIn> createState() => _OTPSignInState();
}

class _OTPSignInState extends State<OTPSignIn> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool visible = false;
  var temp;

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset('assets/images/vruksha_icon.png'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            inputTextField("Contact Number", phoneNumber, context),
            visible ? inputTextField("OTP", otp, context) : SizedBox(),
            !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("Submit"),
          ],
        ),
      ),
    );
  }

  Widget SendOTPButton(String text) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade200,
        ),
        onPressed: () async {
          setState(() {
            visible = !visible;
          });
          temp = await FirebaseAuthentication().sendOTP(phoneNumber.text);
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      );

  Widget SubmitOTPButton(String text) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade200,
        ),
        onPressed: () =>
            FirebaseAuthentication().authenticate(temp, otp.text, context),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      );

  Widget inputTextField(String labelText,
          TextEditingController textEditingController, BuildContext context) =>
      Padding(
        padding: EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            obscureText: labelText == "OTP" ? true : false,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: TextStyle(color: Colors.black87),
              filled: true,
              fillColor: Colors.green.shade200,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
            ),
          ),
        ),
      );
}

class FirebaseAuthentication {
  String phoneNumber = "";

  sendOTP(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult result = await auth.signInWithPhoneNumber(
      '+91$phoneNumber',
    );
    printMessage("OTP Sent to +91 $phoneNumber");
    return result;
  }

  authenticate(ConfirmationResult confirmationResult, String otp,
      BuildContext context) async {
    try {
      UserCredential userCredential = await confirmationResult.confirm(otp);
      if (userCredential.additionalUserInfo!.isNewUser) {
        printMessage("Authentication Successful for new user");
        // Redirect to the Expert Page after successful authentication for new user
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Expert(),
          ),
        );
      } else {
        printMessage("Authentication Successful for existing user");
        // Redirect to the Home Page after successful authentication for existing user
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
        );
      }
    } catch (e) {
      printMessage("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Incorrect OTP. Please try again."),
        ),
      );
    }
  }

  printMessage(String msg) {
    debugPrint(msg);
  }
}
