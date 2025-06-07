import 'dart:convert';

import 'package:apipractice/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThreeApi extends StatefulWidget {
  const ExampleThreeApi({super.key});

  @override
  State<ExampleThreeApi> createState() => _ExampleThreeApiState();
}

class _ExampleThreeApiState extends State<ExampleThreeApi> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUser() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EXAMPLE API THREE'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (snapshot.connectionState==ConnectionState.waiting) { //{Key Point to remember}- we can also write if(snapshot.connectionState==ConnectionState.waiting) instead of !snapshot.has data
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.deepPurpleAccent,
                    ),
                  ));
                } else {
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(snapshot.data![index].name.toString()),
                            Text(snapshot.data![index].company.toString()),
                            Text(snapshot.data![index].address!.city.toString()),//it is nested json file so there is a city inside the address so i access the city by address.city
                            Text(snapshot.data![index].email.toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
