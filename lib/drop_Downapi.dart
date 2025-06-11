import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/drop_downmodel.dart';

class DropDownapi extends StatefulWidget {
  const DropDownapi({super.key});

  @override
  State<DropDownapi> createState() => _DropDownapiState();
}

class _DropDownapiState extends State<DropDownapi> {
  List<DropDownmodel> dropDownList = [];
  Future<List<DropDownmodel>> getDropDownData() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    var data = jsonDecode(
      response.body.toString(),
    ); // because data is coming from list
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        dropDownList.add(DropDownmodel.fromJson(i));
      }
      return dropDownList;
    } else {
      return dropDownList;
    }
  }
  var selectedvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDown Api'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<DropDownmodel>>(
            future: getDropDownData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                  hint: Text('Select Values'),
                  value: selectedvalue,
                  isExpanded: true,
                  items: snapshot.data!.map((e){
                    return DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(e.id.toString())
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedvalue=value;
                    setState(() {

                    });
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
