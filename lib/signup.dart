import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
//-------------THIS IS AN EXAMPLE OF POST API IN WHICH WE SEND DATA TO SERVER VIA POST)
class _SignupState extends State<Signup> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController=TextEditingController();
  void login(String email, String password) async{
    // here we write the main logic for the controller when we click the signup
    try{ // by post we send the data through the api at the server so that user can login successfully
      dynamic response= await http.post(Uri.parse('https://webhook.site/a6458b3c-cdc2-4ac1-a42b-da06bf83fdcd'),
          body:{//When you use http.post(), body contains the data you want to send to the server.
            'email': email,
            'password': password
          }
          );
      if(response.statusCode==200){
        //var data =jsonDecode(response.body.toString()); and print(data)- to check the token value the api is not correct here
        print('Account created successfully');
      }
      else{
        print('Failed');
      }
    } catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, //By using both-will appear in the center of the screen, both vertically and horizontally.,
          children: [
            TextFormField(
               decoration: InputDecoration(
                 label: Text('Email'),
               ),
              controller: emailController,
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
              controller: passwordController,
            ),
            SizedBox(
              height: 30,
            ),
            Material( // when we wrap the inkwell with the material it show the ripple effect
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: (){
                  login(emailController.text.toString(),passwordController.text.toString());// here we created the function of the login name which we declare above
                },
                child: Container(
                  height: 50,
                  child: Center(child: Text('Sign up',style: TextStyle(color: Colors.white),)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
