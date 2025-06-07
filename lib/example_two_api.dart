import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ExampleTwoApi extends StatefulWidget {
  const ExampleTwoApi({super.key});

  @override
  State<ExampleTwoApi> createState() => _ExampleTwoApiState();
}

class _ExampleTwoApiState extends State<ExampleTwoApi> {
  List<Photos> photosList=[];//First Step- our api data of json is in the form of the list so our first step is to create the empty list of the type Photos Model
  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data =jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
       Photos photos=Photos(title: i['title'], url: i['url']);//When you don’t use fromJson() or want quick manual control. Suitable for small/simple cases.
       photosList.add(photos);
      }
      return photosList;
    }
    else{
      return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('API EXAMPLE TWO'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getPhotos(), // here in future builder we call the future function which we created above
                builder: (context,AsyncSnapshot<List<Photos>> snapshot){
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context,index){
                      return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                      ),
                        title: Text(snapshot.data![index].title.toString()),
                        /*
            NetworkImage(snapshot.data![index].url.toString())
            This line is used to load an image from the internet using the URL from the API.

             Breakdown:
             snapshot.data! → forcibly gets the list of photos (we use ! because we’re sure it’s not null at this point).
             [index] → gets the photo at the current list position (e.g., 0, 1, 2...).
             .url → accesses the url field from that Photos object.
             .toString() → ensures it’s a string (even though it likely already is).
N             NetworkImage(...) → Flutter widget that fetches and displays an image from the given URL.
                       */
                      );
                    });
                }),
          )
        ],
      ),
    );
  }
}
//---- Here we create our own api model without using the extension
// we create the model here without the extension just like we do in the post_models.dart
class Photos{
  String title, url;

  Photos({required this.title,required this.url}); // constructor of the class for the model
}