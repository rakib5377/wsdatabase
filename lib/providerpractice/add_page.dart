import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/providerpractice/list_map_provider.dart';
class AddPage extends StatelessWidget {
   AddPage({super.key, this.index = 0, this.title = "", this.desc = "", this.isUpdate= false});
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final int index;
  final String title;
  final String desc;
  final bool isUpdate;


  @override
  Widget build(BuildContext context) {
    if(isUpdate){
      titleController.text = title;
      descController.text = desc;
    }
    return Scaffold(
      appBar: AppBar(title: Text(isUpdate ? "Update" : "Add Page"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.white10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Enter title",
                    border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 22,),
            Container(
              color: Colors.white10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      labelText: "Desc",
                      hintText: "Enter Desc",
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 11,),
            Center(
              child: ElevatedButton(onPressed: (){
                var title = titleController.text;
                var desc = descController.text;
                if(title.isNotEmpty && desc.isNotEmpty){
                  if(isUpdate){
                    context.read<ListMapProvider>().updateData({
                      "name" : title,
                      "mobNo" : desc
                    }, index);
                  }else{
                    context.read<ListMapProvider>().addData({
                      "name" : title,
                      "mobNo" : desc
                    });
                  }
                  Navigator.pop(context);
                }

              }, child: Text(isUpdate? "Update Note":"Add note")),
            ),
          ],
        ),
      ),
    );
  }
}
