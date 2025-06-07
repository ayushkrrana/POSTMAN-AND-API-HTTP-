import 'dart:io';//This lets you use the File class in Dart to handle files like images from your phone.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';//This allows you to pick images from the gallery or camera.
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';//import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// IMAGE PICKER GALLERY APP
class ImageUploadFile extends StatefulWidget {
  const ImageUploadFile({super.key});

  @override
  State<ImageUploadFile> createState() => _ImageUploadFileState();
}

//when we add image to server, we need form-data in postman api for post
class _ImageUploadFileState extends State<ImageUploadFile> {
  File?image; //here we created a file from where we select the image to upload and File is a dart class,"I'm declaring a variable called image which will store a file (like an image file) that comes from the phone's storage."
  final _picker = ImagePicker();//Make an object called _picker using the ImagePicker class so that I can call methods like pickImage() on it."
  bool showSpinner = false;

  //FUNCTION TO PICK IMAGE
  Future getImage() async{  //Function to PickImage
    final pickedFile= await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);//pickImage is the method of the class ImagePicker and we access through the object we created of the ImagePicker() class which is_picker
    if(pickedFile!= null){
      image=File(pickedFile.path);//If a file is picked, store it in image and refresh the UI using setState().
      setState(() {

      });
    }
    else{
      print('No Image is Selected');
    }
  }

  //FUNCTION TO UPLOAD IMAGE
  Future<void> uploadImage() async{
    setState(() {
      showSpinner=true;
    });//Start loading spinner before uploading.

    var stream = http.ByteStream(image!.openRead());//Reads the image file as a stream of bytes to send to the server.OPen.read-This is a method from the File class (dart:io), and it does this:📥 Opens the file and gives a stream of bytes that can be read chunk by chunk.
    var length=await image!.length();//Get the size of the image file.
    var uri=Uri.parse('https://fakestoreapi.com/products');//API URL where the image is to be uploaded.
    var request= http.MultipartRequest('POST', uri);//MultipartRequest is used when you want to send files with a POST request.
    request.fields['title']="Static title";//Adding an extra field in the request body (like in Postman "form-data").
    var multiport= http.MultipartFile('image', stream, length);//assign the image

    request.files.add(multiport);//Attaches the image file to the request.
    var response =await request.send();//Sends the request to the server.
    if(response.statusCode==200){
      setState(() {
        showSpinner=false;
      });
      print('Image Uploaded');
    }
    else{
      setState(() {
        showSpinner=false;
      });
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('IMAGE UPLOAD TO SERVER'),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Picker UI
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child:
                    image == null
                        ? Center(child: Text('Pick Image',style: TextStyle(color: Colors.blue),)) //if else ?:
                        : Container(
                          child: Center(
                            child: Image.file(//	(Image.file is a Widget-	flutter/material.dart	Displays an image from a File object
                              File(image!.path).absolute,//File is a Constructor of File class which Creates a File object from a file path ,This returns the absolute (full) path of the file.
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
              ),
            ),
            SizedBox(height: 150,),
            // Upload Button
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  color: Colors.purple,
                  child: Center(child: Text('UPLOAD')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
* 1. image!.openRead()
image is a File (you created it from File(pickedFile.path)).

.openRead() is a method from the File class in dart:io.

It opens the file as a stream of bytes — a way to read it chunk by chunk (efficient for big files like images).

✅ It returns a Stream<List<int>>.

🧯 2. http.ByteStream(...)
This wraps the byte stream into a format that the http package can use.

dart
Copy
Edit
http.ByteStream(image!.openRead())
This creates a special stream (ByteStream) needed for sending file data to the server using MultipartFile.

✅ So far: You created a file stream in the format HTTP understands.

*/

