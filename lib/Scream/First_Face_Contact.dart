import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:partiel_travaux_pratique_deux/Class/ImageId.dart';
import 'package:partiel_travaux_pratique_deux/Class/Person.dart';
import 'package:partiel_travaux_pratique_deux/Scream/Seconde_Face_Profil.dart';
import 'package:partiel_travaux_pratique_deux/models/User.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<ImageId> myVar = [
    ImageId(pathImage: "images/face3.jpg", Id: 4),
    ImageId(pathImage: "images/face2.jpg", Id: 9),
    ImageId(pathImage: "images/face5.jpg", Id: 2),
    ImageId(pathImage: "images/face1.jpg", Id: 1),
    ImageId(pathImage: "images/face4.jpg", Id: 8),
    ImageId(pathImage: "images/face7.jpg", Id: 6),
    ImageId(pathImage: "images/face8.jpg", Id: 0),
    ImageId(pathImage: "images/face9.jpg", Id: 5),
    ImageId(pathImage: "images/face12.jpg", Id: 7),
    ImageId(pathImage: "images/face11.jpg", Id: 5),
  ];

  List<ImageId> recents = [
    ImageId(pathImage: "images/face3.jpg", Id: 4),
    ImageId(pathImage: "images/face2.jpg", Id: 9),
    ImageId(pathImage: "images/face5.jpg", Id: 2),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Contacts",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage("images/face1.jpg"),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          Contact();
        }),
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<User> users = snapshot.data;
                    return ListView(scrollDirection: Axis.vertical, children: [
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "All Contacts (",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "10",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                      Text(
                                        ")",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Groups",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Search By name or number",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 148, 132, 132)),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Recents",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: recents.map((element) {
                                  return TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Profil(image: element)));
                                    },
                                    child: PersonContact(
                                        image: "${element.pathImage}",
                                        userName: Text(
                                          "${users[element.Id].name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        number:
                                            Text("+${users[element.Id].phone}"),
                                        icon: Icon(Icons.more_horiz)),
                                  );
                                  SizedBox(
                                    height: 10,
                                  );
                                }).toList(),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Contact",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Column(
                            children: myVar.map((e) {
                              return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil(image: e)));
                                  },
                                  //fin on tap
                                  leading: CircleAvatar(
                                    //le rond avec deux caractères
                                    backgroundImage:
                                        AssetImage("${e.pathImage}"),
                                  ),
                                  title: Text(
                                      "${users[e.Id].name}"), //Titre nom et prenom
                                  subtitle: Text(
                                      "+${users[e.Id].phone}"), //Message recents

                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.more_horiz),
                                    ],
                                  ));
                            }).toList(),
                          )
                        ],
                      )
                    ]);
                  } else {
                    return Container(
                      child: Text("Erreu de Connextion"),
                    );
                  }
                }

                return Container();
              }),
        ),
      ),
    );
  }

  Future<List<User>> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List users = jsonDecode(response.body);

    return users.map((e) {
      return User.fromJson(e);
    }).toList();
  }
}
