import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_application/matrimony/dashboard_page.dart';
import 'package:matrimony_application/matrimony/utils_const_string.dart';

class userForm extends StatefulWidget {


  userForm({super.key});

  @override
  State<userForm> createState() => _UserEntryFormPageState();
}

class _UserEntryFormPageState extends State<userForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();

  GlobalKey<FormState> _fromKey = GlobalKey();

  List<String> cities = [
    'Ahmedabad',
    'Morbi',
    'Surat',
    'Mumbai',
    'Baroda',
    'Delhi',
    'Rajkot'
  ];
  String? selectedCity;

  String? gender;
  DateTime? dob;

  List<String> availableHobbies = ['Reading', 'Swimming', 'Travelling', 'Music', 'Photography'];
  String? selectedHobby;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Add User",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _fromKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              //Name field
              TextFormField(
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name!' : null,
                decoration: InputDecoration(
                  labelText: 'Enter your Fullname',
                  hintText: "john singh",
                  prefixIcon: const Icon(Icons.perm_identity_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //Address field
              TextFormField(
                controller: addressController,
                validator: (value) =>
                    value!.isEmpty ? 'please enter your address!' : null,
                decoration: InputDecoration(
                  labelText: 'Enter your Address',
                  hintText: 'Address',
                  prefixIcon: const Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //Email field
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty || !RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)
                        ? 'enter valid email!'
                        : null,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  hintText: 'example@gmail.com',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //mobile field
              TextFormField(
                controller: phoneController,
                validator: (value) => value!.isEmpty || value.length != 10
                    ? 'enter valid phone number!'
                    : null,
                decoration: InputDecoration(
                  labelText: 'Enter your phone',
                  hintText: '1234567890',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today_rounded),
                      labelText: "Select DOB"),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if(pickeddate != null){
                      setState(() {
                        dateController.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                      });
                    }
                  },
                ),
              ),

              SizedBox(height: 10),

              //city field
              DropdownButtonFormField<String>(
                value: selectedCity,
                validator: (value) =>
                    value!.isEmpty ? 'please select city!' : null,
                items: cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'select city',
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              SizedBox(height: 20),

              //gender radio but
              Row(
                children: [
                  Text('Gender:'),
                  SizedBox(width: 10),
                  Expanded(
                      child: Row(
                    children: [
                      Radio(
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                      Text('Female'),
                    ],
                  )),
                ],
              ),
              SizedBox(height: 10),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedHobby,
                items: availableHobbies.map((hobby) {
                  return DropdownMenuItem(value: hobby, child: Text(hobby));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedHobby = value;
                    hobbiesController.clear(); // Clear manual entry if a dropdown value is selected
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Hobbies',
                  prefixIcon: const Icon(Icons.sports_esports),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),

              const SizedBox(height: 10),
              if (selectedHobby == null)
                TextFormField(
                  controller: hobbiesController,
                  decoration: InputDecoration(
                    labelText: 'Other Hobbies (if any u like)',
                    prefixIcon: const Icon(Icons.sports_esports),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),

              SizedBox(height: 20,),

              //Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> map = {};
                      map[FULLNAME] = nameController.text.toString();
                      map[ADDRESS] = addressController.text.toString();
                      map[EMAIL] = emailController.text.toString();
                      map[MOBILENUMBER] = phoneController.text.toString();
                      map[DOB] = dateController.text.toString();
                      map[CITY] = selectedCity;
                      map[GENDER] = gender;

                      Navigator.pop(context, map);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: Text(
                      'save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: Text(
                      'Discard',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}