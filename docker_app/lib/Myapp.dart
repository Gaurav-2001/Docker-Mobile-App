import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //var for first tab
  late String name;
  late String image;
  String c_cmd = "";
  String c_result = "";
  //var for second tab
  String cmd = "";
  String result = "";
  web() async {
    var url = Uri.http(
      '192.168.27.35',
      '/cgi-bin/app.py',
      {'cmd': "sudo " + cmd},
    );
    var response = await http.get(url);
    setState(
      () {
        result = response.body;
      },
    );
  }

  cont() async {
    c_cmd = "docker run -dit --name $name $image";
    var url = Uri.http(
      '192.168.27.35',
      '/cgi-bin/app.py',
      {'cmd': "sudo " + c_cmd},
    );
    var response = await http.get(url);
    setState(
      () {
        c_result = response.body;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    child: Image.asset("assets/3.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              onChanged: (value) {
                                name = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Enter Name of Container",
                                fillColor: Colors.deepPurple[700],
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextField(
                              onChanged: (value) {
                                image = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Enter Name of Image",
                                fillColor: Colors.deepPurple[700],
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 50, left: 50),
                            child: TextButton(
                              onPressed: cont,
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 20),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(20),
                                backgroundColor: Colors.deepPurple.shade700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              c_result,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 500,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              child: ListView(
                children: [
                  Image(
                    image: NetworkImage(
                      'https://media.wired.com/photos/5926b2f3af95806129f50553/master/w_2560%2Cc_limit/Laptop_GettyImages-179302961.jpg',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Enter the command : ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) {
                      cmd = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.input),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 100,
                      left: 100,
                    ),
                    child: ElevatedButton(
                      onPressed: web,
                      child: Text("Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Output",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      result,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Docker"),
              ),
              Tab(
                child: Text("Command-line"),
              ),
            ],
          ),
          title: Text("Docker App"),
          leading: Container(
            child: Image.asset('assets/1.png'),
          ),
          actions: [
            IconButton(
              onPressed: null,
              icon: Image(
                image: AssetImage('assets/2.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
