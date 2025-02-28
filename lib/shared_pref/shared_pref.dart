import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({super.key});

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  TextEditingController nameController = TextEditingController();
  static final String KEYNAME = "name";
  var nameValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }
  void getValue() async {
    var pref = await SharedPreferences.getInstance();
    var getName = pref.getString(KEYNAME);
    nameValue = getName ?? "No value";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared  pref"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(nameValue),
            SizedBox.square(dimension: 20,),
            Container(
              width: 300,decoration: BoxDecoration(color: Colors.white10,borderRadius: BorderRadius.circular(11)),
              child: Padding(
                padding: const EdgeInsets.only(left: 11),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox.square(dimension: 20,),
            OutlinedButton(onPressed: () async{
              var name = nameController.text;
              var pref = await SharedPreferences.getInstance();
              pref.setString(KEYNAME, name);
              setState(() {
                getValue();
              });
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
