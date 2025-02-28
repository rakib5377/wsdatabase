import 'package:flutter/material.dart';
import 'package:wsdtabse/dbpractice/dbservice.dart';

class Homedb extends StatefulWidget {
  const Homedb({super.key});

  @override
  State<Homedb> createState() => _HomedbState();
}

class _HomedbState extends State<Homedb> {
  List<Map<String, dynamic>> allNotes = [];
  DbService? dbRef;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refresh();
  }
  void refresh() async {
    dbRef = await DbService.getInstance;
    allNotes =  await dbRef!.fetchData();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes practice"),),
      body: allNotes.isEmpty ? Center(child: Text("No data yet !!"),)
      : ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: Text("${index +1}"),
              title: Text(allNotes[index][DbService.TABLE_NOTE_TITLE]),
              subtitle: Text(allNotes[index][DbService.TABLE_NOTE_DESC]),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context, builder: (context){
                            titleController.text = allNotes[index][DbService.TABLE_NOTE_TITLE];
                            descController.text = allNotes[index][DbService.TABLE_NOTE_DESC];
                        return botoomSheetWidget(isUpdate: true, id: allNotes[index][DbService.TABLE_NOTE_SNO]);
                      });
                    }, icon: Icon(Icons.edit_outlined)),
                    IconButton(onPressed: ()async{
                      bool check = await dbRef!.deleteData(id: allNotes[index][DbService.TABLE_NOTE_SNO]);
                      if(check){
                        refresh();
                      }
                    }, icon: Icon(Icons.delete_outline,color: Colors.red,))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(
          isScrollControlled: true,
            context: context, builder: (context){
          return botoomSheetWidget();
        }).whenComplete((){
          setState(() {
            titleController.clear();
            descController.clear();
          });
        });
      },
      child: Icon(Icons.add),),
    );
  }

  Widget botoomSheetWidget({bool isUpdate = false, int id = 0}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            Text(isUpdate? "Update Note" : "Add Note", style: TextStyle(fontSize: 22),),
            SizedBox(height: 22,),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11)
                )
              ),
            ),
            SizedBox(height: 22,),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  labelText: "Desc",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  )
              ),
            ),
            SizedBox(height: 22,),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () async{
                  var title = titleController.text;
                  var desc = descController.text;
                  if(title.isNotEmpty && desc.isNotEmpty){
                    bool check = isUpdate ? await dbRef!.updateData(mTitle: title, mDesc: desc, id: id)
                        : await dbRef!.insertNote(mTitle: title, mDesc: desc);
                    if(check){
                      refresh();
                      print("note added");
                      Navigator.pop(context);
                    }
                  }
                }, child: Text(isUpdate? "Update Note" : "Add Note"),style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.black),shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11))
                )),),
                SizedBox(width: 22,),
                Expanded(child: OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel"),style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.black),shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11))
                )),),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}
