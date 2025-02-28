import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/services/DBProvider.dart';
import 'package:wsdtabse/services/dbhelper.dart';
import 'package:wsdtabse/ui/addpage.dart';
import 'package:wsdtabse/ui/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /*List<Map<String , dynamic>> allNotes = [];
  DBhelper? dbRef;
  String errMsg = "";*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DBProvider>().getInitialNotes();
   /* dbRef = DBhelper.getInstance;
    refresh();*/
  }
  /*void refresh() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {

    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Notes"),
    actions: [PopupMenuButton(itemBuilder: (context){
      return [
        PopupMenuItem(child: Row(
          children: [
            Icon(Icons.settings),
            SizedBox(width: 11,),
            Text("Settings"),
          ],
        ),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
        },)
      ];
    })],
    ),
    body: Consumer<DBProvider>(
        builder: (ctx, provider, __){
          List<Map<String, dynamic>> allNotes = ctx.read<DBProvider>().getNotes();
          return allNotes.isEmpty ? Center(child: Text("No Notes Now !!"),)
              : ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (context, index){
                return ListTile(
                  //leading: Text(allNotes[index][DBhelper.table_note_sno].toString()),
                  leading: Text("${index+1}"),
                  title: Text(allNotes[index][DBhelper.table_note_title]),
                  subtitle: Text(allNotes[index][DBhelper.table_note_desc]),
                  trailing: SizedBox(width: 60,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPage(
                          isUpdate: true, id: allNotes[index][DBhelper.table_note_sno],
                            title: allNotes[index][DBhelper.table_note_title],
                            desc: allNotes[index][DBhelper.table_note_desc],

                            )));
                        /*showModalBottomSheet(
                      isScrollControlled: true,
                      context: context, builder: (context){
                        titleController.text = allNotes[index][DBhelper.table_note_title];
                        descController.text = allNotes[index][DBhelper.table_note_desc];
                    return getBottomSheetWidget(isUpdate: true, id: allNotes[index][DBhelper.table_note_sno]);
                  });*/
                      },child: Icon(Icons.edit),),
                      InkWell(onTap:()async{
                        context.read<DBProvider>().deleteData(allNotes[index][DBhelper.table_note_sno]);
                        /*bool check = await dbRef!.deleteNote(id: allNotes[index][DBhelper.table_note_sno]);
                        if(check){
                          refresh();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Successfully")));
                        }*/
                      },child: Icon(Icons.delete),)
                    ],
                  ),
                  ),
                );
              });
        }
    ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
        /*showModalBottomSheet(
          isScrollControlled: true,
            context: context, builder: (context){
          return getBottomSheetWidget();*/
        }
        /*.whenComplete((){
          setState(() {
            titleController.clear();
            descController.clear();
            errMsg = "";
          });
        });*/
      ,
        child: Icon(Icons.add),backgroundColor: Colors.pink.shade400,foregroundColor: Colors.white,),);
  }
}
