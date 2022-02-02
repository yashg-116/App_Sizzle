import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'Homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ScreenFirst extends StatefulWidget {
  // const ScreenFirst({Key? key}) : super(key: key);
  @override
  _ScreenFirstState createState() => _ScreenFirstState();
}

class _ScreenFirstState extends State<ScreenFirst> {
  bool stringcheck(){
   String text1;
   text1=nameController.text ;
   if(text1=="")
     return true;
   else
     return false;
  }
  File? image;
  TextEditingController nameController = new TextEditingController();
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40),
          primary: Colors.pink,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        onPressed: onClicked,
      );
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("App Sizzle"),
          backgroundColor: Colors.pink,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Text(
                "Enter your name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextField(
                controller: nameController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Your name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Spacer(),
              image != null
                  ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : FlutterLogo(size: 160),
              const SizedBox(height: 24),
              Text(
                "Your Fitness Checker",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              buildButton(
                title: "Pick your image",
                icon: Icons.image_outlined,
                onClicked: () =>
                {
                  if(stringcheck()==true)
                {
                  _showToast(context),
                }
                  else
                  pickImage(ImageSource.gallery)
                },
              ),
              const SizedBox(height: 20),
              buildButton(
                title: "Calculate your BMI",
                icon: Icons.person_add_alt_1_rounded,
                onClicked: () => {
                if(stringcheck()==true){
                  _showToast(context),
                }
                  else
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()))
                },
              ),
              Spacer(),
            ],
          ),
        ));
  }
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text("Please Enter your name first!!"),
      ),
    );
  }
}

