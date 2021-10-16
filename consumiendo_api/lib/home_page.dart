import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String? stringRespose;
Map? mapRespose;
Map? dataRespose;
List? listRespose;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        stringRespose = response.body;
        mapRespose = json.decode(response.body);
        listRespose = mapRespose!['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Consumo de API'),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                width: width * 0.8,
                color: Colors.white,
                child: Card(
                  color: Colors.blue,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(listRespose![index]['avatar']),
                        ),
                        Visibility(
                          child: Text(listRespose![index]['id'].toString()),
                          visible: false,
                        ),
                        Text(listRespose![index]['email'].toString()),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  listRespose![index]['first_name'].toString(),
                                  textAlign: TextAlign.end),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                  listRespose![index]['last_name'].toString(),
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: listRespose == null ? 0 : listRespose!.length,
          )),
    );
  }
}
