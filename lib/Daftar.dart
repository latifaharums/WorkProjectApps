import 'package:flutter/material.dart';
import 'HalamanUtama.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: RegisterPage(),
    );
  }
}
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("Hello There!", style: TextStyle(
                fontSize: 35
            ),),
            Text("Create New Account", style: TextStyle(
                fontSize: 18,
                color: Colors.grey
            ),),
            SizedBox(height: 20,),
            Text("User Name", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Example: latifaharums"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 20,),
            Text("Password", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Enter your password here"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 20,),
            Text("Nama Lengkap", style: TextStyle(
              fontSize: 23,
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Example: Latifah Arum Sulistyaningsih"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),

            SizedBox(height: 20,),
            Text("Tanggal Lahir", style: TextStyle(
              fontSize: 23,
            ),),

            DateTimePicker(
              initialValue: '',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Select Date',
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),

            SizedBox(height: 20,),
            Text("Asal Negara", style: TextStyle(
              fontSize: 23,
            ),),

            CountryListPick(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: Text('Choose Your Country'),
                ),

                theme: CountryTheme(
                  isShowFlag: true,
                  isShowTitle: true,
                  isShowCode: true,
                  isDownIcon: true,
                  showEnglishName: true,
                ),
                // Set default value
                initialSelection: '+62',
                // or
                // initialSelection: 'US'
                onChanged: (CountryCode code) {
                  print(code.name);
                  print(code.code);
                  print(code.dialCode);
                  print(code.flagUri);
                },
                // Whether to allow the widget to set a custom UI overlay
                useUiOverlay: true,
                // Whether the country list should be wrapped in a SafeArea
                useSafeArea: false
            ),

            SizedBox(height: 10,),
            InkWell(
              onTap: openHomePage,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      color: Color(0xFF2596BE)
                  ),
                  child: Text("Register", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}