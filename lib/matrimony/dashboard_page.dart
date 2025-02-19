import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_application/matrimony/about_us_page.dart';
import 'package:matrimony_application/matrimony/user_crud.dart';
import 'package:matrimony_application/matrimony/user_details_screen.dart';
import 'package:matrimony_application/matrimony/user_form_page.dart';
import 'package:matrimony_application/matrimony/utils_const_string.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  // List<Map<String,String>> filtereData = [];

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User _user = User();
  int selectedBottomIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            'MATRIMONY-APP',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 80,
          ),
          Icon(Icons.insert_emoticon_rounded),
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.deepPurple.shade300,
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.deepPurple.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.account_circle_sharp,
                size: 100,
              )),
              ListTile(
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
                title: Text("Dashboard"),
              ),
              ListTile(
                // onTap: () {
                //   Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ListOfUser(user: _user,),
                //   ));
                // },
                title: Text("Favourite Users"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutUsPage(),
                  ));
                },
                title: Text("About Us"),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Users",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
          Column(children: [
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => userForm(),
                      )).then((value) {
                    if (value != null) {
                      setState(() {
                        _user.userList.insert(0, value);
                        print(_user.userList);
                      });
                    }
                  });
                },
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                label: Text('Create User', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search with name or city',
                    suffixIcon: Icon(Icons.search_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ]),
          SizedBox(
            height: 20,
          ),
          _user.userList.isEmpty
              ? Center(child: Text('No User Found'))
              : Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _user.userList.length,
                    itemBuilder: (context, index) {
                      return getCarsOfUser(index);
                    },
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => userForm(),
              )).then((value) {
            if (value != null) {
              setState(() {
                _user.userList.insert(0, value);
                print(_user.userList);
              });
            }
          });
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedBottomIndex = index;
            });
          },
          currentIndex: selectedBottomIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepPurple.shade400,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(Icons.arrow_back),
              label: 'Back',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Badge(child: Icon(Icons.home)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(Icons.list),
              label: 'UserList',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(Icons.details_sharp),
              label: 'About Us',
            ),
          ]),
    );
  }

  Widget getCarsOfUser(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserDetailPage(
                user: _user.userList[index],
              ),
            ));
          },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        _user.userList[index][FULLNAME],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      // Text("DOB", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),textAlign: TextAlign.left,),
                      // Text(_user.userList[index][DOB], style: TextStyle(fontSize: 9),),
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Text(
                        _user.userList[index][MOBILENUMBER],
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border_sharp)),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return userForm(
                              userDetail: _user.userList[index],
                            );
                          },
                        )).then((value) {
                          _user.userList[index] = value;
                          setState(() {});
                        });
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text("Delete"),
                                content: Text("Are you want to delete user??"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _user.userList.removeAt(index);
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No"))
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
