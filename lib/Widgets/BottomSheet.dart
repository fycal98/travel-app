import 'dart:ui';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:topdeck/Screens/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topdeck/Screens/StartSceen.dart';
import '../Data.dart';
import 'package:provider/provider.dart';

enum sexe { male, female }

class Sheet extends StatefulWidget {
  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  FocusNode focus = FocusNode();
  final form = GlobalKey<FormState>();
  String profile = '';
  final Picker = ImagePicker();
  Function changeprofile(var p) {
    setState(() {
      profile = p;
    });
  }

  sexe s = sexe.male;
  Function changegender() {
    setState(() {
      s = s == sexe.female ? sexe.male : sexe.female;
    });
  }

  var Nationality;
  Function SelectNationality(String value) {
    setState(() {
      Nationality = value;
    });
  }

  FocusNode email = FocusNode();

  FocusNode password = FocusNode();

  FocusNode name = FocusNode();
  TextEditingController cemail = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController cname = TextEditingController();

  void submit(BuildContext context) async {
    if (form.currentState.validate() && profile != '') {
      print(
          '{"username":"${cname.text}","password" : "${cpassword.text}","email":"${cemail.text}","age":22,"gender":"${s.toString()}","nationality":"${Nationality}"}');
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.1.50:3000/user/signin'))
        ..fields['data'] =
            '{"username":"${cname.text}","password" : "${cpassword.text}","email":"${cemail.text}","age":22,"gender":"${s.toString()}","nationality":"${Nationality}"}'
        ..files.add(await http.MultipartFile.fromPath(
          'avatar',
          profile,
        ));
      var res = await request.send();
      var resData = await res.stream.bytesToString();
      if (jsonDecode(resData).containsKey('error')) {
        print(resData);
        return;
      }
      Map data = jsonDecode(resData);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('userInfo',
          [data['token'], data['email'], data['username'], data['imageUrl']]);
      Provider.of<Data>(context, listen: false).changeUserInfo(
          [data['token'], data['email'], data['username'], data['imageUrl']]);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontfactor = size.height / 720;

    var hintStyle = TextStyle(
        color: Colors.white.withOpacity(0.6), fontSize: 12 * fontfactor);
    var inputStyle = TextStyle(color: Colors.white, fontSize: 15 * fontfactor);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Container(
                height: 500 * fontfactor,
                decoration: BoxDecoration(
                    //
                    color: Colors.white.withOpacity(0),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35 * fontfactor),
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 5 * fontfactor,
                          width: 100 * fontfactor,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20 * fontfactor),
                          ),
                        ),
                        Avatar(
                          changeprofile: changeprofile,
                          Picker: Picker,
                          profile: profile,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15 * fontfactor),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20 * fontfactor),
                                child: TextFormField(
                                  controller: cemail,
                                  autofocus: false,
                                  focusNode: email,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (!value.contains('@')) {
                                      return 'enter a valid email';
                                    }

                                    return null;
                                  },
                                  style: inputStyle,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'enter your email address',
                                    hintStyle: hintStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15 * fontfactor),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20 * fontfactor),
                                child: TextFormField(
                                  controller: cpassword,
                                  focusNode: password,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.length < 8) {
                                      return 'enter a stronger password';
                                    }

                                    return null;
                                  },
                                  style: inputStyle,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'enter your password',
                                    hintStyle: hintStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15 * fontfactor),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20 * fontfactor),
                                child: TextFormField(
                                  controller: cname,
                                  focusNode: name,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value.length < 4) {
                                      return 'name too short';
                                    }
                                    if (value.length > 12) {
                                      return 'name too long';
                                    }

                                    return null;
                                  },
                                  style: inputStyle,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'enter your name',
                                    hintStyle: hintStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        CountryRow(
                          value: Nationality,
                          select: SelectNationality,
                        ),
                        GenderRow(
                          changegender: changegender,
                          s: s,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed: () {
                            email.unfocus();
                            password.unfocus();
                            name.unfocus();
                            submit(context);
                          },
                          color: Colors.blue.shade500,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40 * fontfactor,
                                vertical: 15 * fontfactor),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({this.changeprofile, this.profile, this.Picker});
  final Function changeprofile;
  final String profile;
  final Picker;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundImage: profile != '' ? FileImage(File(profile)) : null,
      backgroundColor: Colors.white.withOpacity(0.1),
      child: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: () async {
            final p = await Picker.getImage(
              source: ImageSource.gallery,
              imageQuality: 50,
            );
            changeprofile(p.path);
          }),
    );
  }
}

class CountryRow extends StatelessWidget {
  Function select;
  String value;
  CountryRow({this.select, this.value});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontfactor = size.height / 720;
    var hintStyle = TextStyle(
        color: Colors.white.withOpacity(0.6), fontSize: 12 * fontfactor);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Nationality',
            style: TextStyle(color: Colors.white, fontSize: 15 * fontfactor),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
              padding: EdgeInsets.only(left: 20 * fontfactor),
              child: DropdownButton<String>(
                  value: value,
                  style: hintStyle,
                  dropdownColor: Colors.white.withOpacity(0.5),
                  hint: Text(
                    'select your country',
                    style: hintStyle,
                  ),
                  isDense: true,
                  underline: Container(),
                  items: countryList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (i) {
                    select(i);
                  })),
        )
      ],
    );
  }
}

class GenderRow extends StatelessWidget {
  Function changegender;
  sexe s;
  GenderRow({this.changegender, this.s});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var fontfactor = size.height / 720;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Gender',
            style: TextStyle(color: Colors.white, fontSize: 15 * fontfactor),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Row(
              children: [
                Expanded(
                    child: TextButton.icon(
                        onPressed: changegender,
                        icon: Icon(
                          s == sexe.male
                              ? Icons.circle
                              : Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 12 * fontfactor,
                        ),
                        label: Text(
                          'Male',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12 * fontfactor),
                        ))),
                Expanded(
                    child: TextButton.icon(
                        onPressed: changegender,
                        icon: Icon(
                          s == sexe.female
                              ? Icons.circle
                              : Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 12 * fontfactor,
                        ),
                        label: Text(
                          'Female',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12 * fontfactor),
                        ))),
              ],
            ),
          ),
        )
      ],
    );
  }
}

const countryList = [
  "Afghanistan",
  "Åland Islands",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas (the)",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia",
  "Burkina Faso",
  "Burundi",
  "Cabo Verde",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Chile",
  "China",
  "Christmas Island",
  "Cocos",
  "Colombia",
  "Comoros ",
  "Congo ",
  "Congo",
  "Cook Islands ",
  "Costa Rica",
  "Croatia",
  "Cuba",
  "Curaçao",
  "Cyprus",
  "Czechia",
  "Côte d'Ivoire",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Eswatini",
  "Ethiopia",
  "Falkland Islands",
  "Faroe Islands",
  "Gambia (the)",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guernsey",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iraq",
  "Ireland",
  "Isle of Man",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jersey",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea",
  "Korea (the Republic of)",
  "Kuwait",
  "Kyrgyzstan",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macao",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Mexico",
  "Micronesia ",
  "Moldova",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands (the)",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger (the)",
  "Nigeria",
  "Niue",
  "Pakistan",
  "Palau",
  "Palestine, State of",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines (the)",
  "Pitcairn",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Réunion",
  "Saint Barthélemy",
  "Saint Helena",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Martin",
  "Saint Vincent",
  "Samoa",
  "San Marino",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Georgia ",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "Sudan (the)",
  "Suriname",
  "Sweden",
  "Switzerland",
  "Taiwan ",
  "Tajikistan",
  "Thailand",
  "Timor-Leste",
  "Togo",
  "Tokelau",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Venezuela (",
  "Viet Nam",
  "Western Sahara",
  "Yemen",
  "Zambia",
  "Zimbabwe"
];
