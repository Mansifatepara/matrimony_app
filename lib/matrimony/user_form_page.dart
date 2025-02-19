import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_application/matrimony/utils_const_string.dart';

class userForm extends StatefulWidget {
  Map<String, dynamic>? userDetail;
  userForm({super.key, this.userDetail});

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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  List<String> userHobbies = [];

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
  //
  // List<String> availableHobbies = [
  //   'Reading',
  //   'Swimming',
  //   'Travelling',
  //   'Music',
  //   'Photography'
  // ];
  // String? selectedHobby;

  bool passwordVisibe = false;
  bool confirmpasswordVisibe = false;
  bool isPlaying = false;
  bool isCooking = false;
  bool isDancing = false;
  bool isOtherHobby = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.userDetail != null){
      nameController.text = widget.userDetail![FULLNAME];
      addressController.text = widget.userDetail![ADDRESS];
      emailController.text = widget.userDetail![EMAIL];
      phoneController.text = widget.userDetail![MOBILENUMBER];
      dateController.text = widget.userDetail![DOB];
      passwordController.text = widget.userDetail![PASSWORD];
      confirmpasswordController.text = widget.userDetail![CONFIRMPASSWORD];
      gender = widget.userDetail![GENDER];
      selectedCity = widget.userDetail![CITY];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.userDetail == null ?
          "Add User" : "Edit User",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _fromKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                //Name field
                TextFormField(
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')), // Only letters
                    // CapitalizeTextInputFormatter()
                  ],
                  controller: nameController,
                  validator: (String? value) =>
                      value!.isEmpty ? 'Please enter your name!' : null,
                  decoration: InputDecoration(
                    labelText: 'Enter your Fullname',
                    hintText: "john singh",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //Address field
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: addressController,
                  validator: (String? value) =>
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
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (String? value) => value!.isEmpty ||
                          !RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)
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
                  maxLength: 10,
                  controller: phoneController,
                  // validator: (String? value) =>
                  //     value!.isEmpty || value.length != 10
                  //         ? 'enter valid phone number!'
                  //         : null,
                  validator: (String? value) => value!.isEmpty || value.length!=10 ||
                      !RegExp(r'^\d{10}$')
                          .hasMatch(value)
                      ? 'enter valid Phone Number!'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Enter your phone',
                    hintText: '1234567890',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  keyboardType: TextInputType.number,
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

                      if (pickeddate != null) {
                        setState(() {
                          dateController.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ),
                ),

                SizedBox(height: 10),

                //city field
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  validator: (String? value) =>
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

                // DropdownButtonFormField<String>(
                //   value: selectedHobby,
                //   items: availableHobbies.map((hobby) {
                //     return DropdownMenuItem(value: hobby, child: Text(hobby));
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedHobby = value;
                //       hobbiesController
                //           .clear(); // Clear manual entry if a dropdown value is selected
                //     });
                //   },
                //   decoration: InputDecoration(
                //     labelText: 'Select Hobbies',
                //     prefixIcon: const Icon(Icons.sports_esports),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(30)),
                //   ),
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hobbies : ",
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isPlaying,
                                onChanged: (value) {
                                  setState(() {
                                    isPlaying = !isPlaying;
                                    if(isPlaying){
                                      userHobbies.add('Playing');
                                    }
                                  });
                                },
                              ),
                              Text(
                                "Playing",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isDancing,
                                onChanged: (value) {
                                  setState(() {
                                    isDancing = !isDancing;
                                    if(isDancing){
                                      userHobbies.add('Dancing');
                                    }
                                  });
                                },
                              ),
                              Text(
                                "Dancing",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isCooking,
                                onChanged: (value) {
                                  setState(() {
                                    isCooking = !isCooking;
                                    if(isCooking){
                                      userHobbies.add('Cooking');
                                    }
                                  });
                                },
                              ),
                              Text(
                                "Cooking",
                                style: TextStyle(color: Colors.black
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isOtherHobby,
                                onChanged: (value) {
                                  setState(() {
                                    isOtherHobby = !isOtherHobby;
                                  });
                                },
                              ),
                              Text(
                                "Other Hobby",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter a password';
                    if (value.length < 6) return 'Password must be at least 6 characters long';
                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                      return 'Password must contain at least one special character';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Create your strong password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        passwordVisibe = !passwordVisibe;
                      });
                    }, icon:Icon( passwordVisibe ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,))
                  ),
                  obscureText: !passwordVisibe,
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: confirmpasswordController,
                  validator: (value){
                    if (value != passwordController.text){
                      return 'password do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter confirm password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          confirmpasswordVisibe = !confirmpasswordVisibe;
                        });
                      }, icon:Icon( confirmpasswordVisibe ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,))
                  ),
                  obscureText: !confirmpasswordVisibe,
                ),

                const SizedBox(height: 10),
                // if (selectedHobby == null)
                  // TextFormField(
                  //   controller: hobbiesController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Other Hobbies (if any u like)',
                  //     prefixIcon: const Icon(Icons.sports_esports),
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30)),
                  //   ),
                  // ),

                SizedBox(
                  height: 20,
                ),

                //Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          Map<String, dynamic> map = {};
                          map[FULLNAME] = nameController.text.toString();
                          map[ADDRESS] = addressController.text.toString();
                          map[EMAIL] = emailController.text.toString();
                          map[MOBILENUMBER] = phoneController.text.toString();
                          map[DOB] = dateController.text.toString();
                          map[CITY] = selectedCity;
                          map[GENDER] = gender;
                          map[HOBBIES] = userHobbies;
                          map[PASSWORD] = passwordController.text;
                          map[CONFIRMPASSWORD] = confirmpasswordController.text;

                          Navigator.pop(context, map);
                          setState(() {});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text(
                        widget.userDetail == null ?
                        'Save' : 'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        nameController.clear();
                        addressController.clear();
                        emailController.clear();
                        phoneController.clear();
                        dateController.clear();
                        selectedCity = null;
                        gender = null;
                        hobbiesController.clear();
                        passwordController.clear();
                        confirmpasswordController.clear();
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
      ),
    );
  }
}
//
// class CapitalizeTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     return newValue.copyWith(
//       text: newValue.text.isNotEmpty
//           ? newValue.text[0].toUpperCase() + newValue.text.substring(1)
//           : '',
//       selection: newValue.selection,
//     );
//   }
// }