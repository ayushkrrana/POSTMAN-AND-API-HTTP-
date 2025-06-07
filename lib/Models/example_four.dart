import 'dart:convert';

import 'package:apipractice/Models/product_model.dart';
import 'package:apipractice/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

// this example is different because in this our json file starts with object not array, previously in our examples our json data starts from array like[ { when we hit in url in the postmain api

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  
  Future<ProductModel> getProduct() async{
    
    final respose = await http.get(Uri.parse('https://webhook.site/63f015dc-010f-4c04-88e3-16f1ea565390'));
    var data= jsonDecode(respose.body);
    if(respose.statusCode==200){
      return ProductModel.fromJson(data);
    }
    else{
      return ProductModel.fromJson(data);
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API EXAMPLE FOUR'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(future: getProduct(), builder: (context,snapshot){ /*builder: (context, snapshot) { ... }
                                                                                            This is the function that builds the UI when the Future completes.

                                                                                              snapshot contains the data, loading state, or error.*/
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length, //!- indicate that this value is 100% sure that it is not null
                  itemBuilder: (context,index){
                return Card(
                  child: Column(
                    children: [
                      Text(index.toString())
                    ],
                  ),
                );
              });
            } ),
          )
        ],
      )
      );
  }
}
