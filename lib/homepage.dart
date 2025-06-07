import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/posts_models.dart'; // here we add alias for the import library for the http

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//---------------------------------------------------------------------------------
class _HomeScreenState extends State<HomeScreen> {
  List<PostsModels> postList = []; // we create our own list because the array name is not defined, This creates an empty list of PostsModels to hold the data fetched from the API.
  Future<List<PostsModels>> getPostApi() async {//This is an async function that will fetch and return a list of PostsModels objects.
    final response = await http.get( //http.get(Uri.parse) it will fetch and parse all the json data from the api
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );//It sends a GET request to the fake API (JSONPlaceholder) to retrieve a list of posts.
    var data = jsonDecode(response.body.toString());//  var data = jsonDecode(response.body.toString());- it convert into a list of map which further converted into the PostModel by doing PostModel.fromJson(i)
    if (response.statusCode == 200) {
      for (Map i in data) {//i-A temporary variable that holds each Map inside data during the loop
        postList.add(PostsModels.fromJson(i));//(When we do PostModels.fromJson(i) - it convert the json Map value which is decoded earlier into the PostModel Objects
        // Iterates over each post in the JSON data and converts it into a PostsModels object, then adds it to the list.
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A P I'),backgroundColor: Colors.blue,centerTitle: true,),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(//FutureBuilder is a widget that waits for a future (here, the API call) and rebuilds the UI when the future completes.
              future: getPostApi(),
              builder: (context, snapshot) {/*The builder provides two things:

                context: current location in widget tree
                snapshot: holds the result/state of the future (loading, hasData, hasError, etc.)*/
                if (!snapshot.hasData) {
                 return Text('Loading');
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(postList[index].title.toString()),
                            Text(postList[index].title.toString()),
                          ],
                        ) ,
                      );
                    },
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
