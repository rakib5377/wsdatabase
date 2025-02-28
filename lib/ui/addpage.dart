import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/services/DBProvider.dart';
import 'package:wsdtabse/services/dbhelper.dart';
import 'package:wsdtabse/services/theme_provider.dart';
class AddPage extends StatefulWidget {
  int id;
  bool isUpdate;
  String title;
  String desc;

  AddPage({super.key, this.isUpdate = false, this.id = 0, this.title="", this.desc = ""});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  DBhelper? dbRef= DBhelper.getInstance;

  String  errMsg = "";

  @override
  Widget build(BuildContext context) {
    if(widget.isUpdate){
      titleController.text = widget.title;
      descController.text = widget.desc;
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.isUpdate? "Update Note" : "Add Note"),
        actions: [
        SizedBox(width: 160,
          child: Consumer<ThemeProvider>(builder: (ctx, provider, __){
            return SwitchListTile(value: provider.getThemeValue(),
                onChanged: (newvalue){
              provider.UpdateThemeMode(value: newvalue);
            });
          }),
        )
        ],),
      body:

      Container(
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            SizedBox.square(dimension: 11,),
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: InputDecoration(
                  label: Text("Title *"),
                  hintText: "Enter Title here",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  )
              ),
            ),
            SizedBox.square(dimension: 11,),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: "Desc *",
                  hintText: "Enter Desc here",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  )
              ),),
            SizedBox.square(dimension: 11,),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: ()async{
                  var title = titleController.text;
                  var desc = descController.text;
                  if(title.isNotEmpty && desc.isNotEmpty){
                    if(widget.isUpdate){
                      context.read<DBProvider>().updateData(title, desc, widget.id);
                      print("Note updated");
                    }
                    else{

                      context.read<DBProvider>().addData(title, desc);
                      print("Note added");
                    }
                    Navigator.pop(context);
                    /*if(check){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                      Text(isUpdate? "Updated Successfully" : "Note Added Successfully")));

                      Navigator.pop(context);
                    }*/
                  } else {
                       errMsg = "Enter all required field";
                       setState(() {

                       });
                  }

                }
                  ,style: OutlinedButton.styleFrom(shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))), child: Text(widget.isUpdate ? "Update Note" : "Add Note"),)),
                SizedBox.square(dimension: 11,),
                Expanded(child: OutlinedButton(onPressed: (){
                  Navigator.pop(context);
                },style: OutlinedButton.styleFrom(shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))), child: Text("Cancel"),)),
              ],
            ),
            SizedBox.square(dimension: 11,),
            Center(child: Text(errMsg))
          ],
        ),
      ),
    )
    );
  }
}
