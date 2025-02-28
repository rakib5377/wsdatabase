import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/providerpractice/list_map_provider.dart';
class UpdatePage extends StatelessWidget {
  UpdatePage({super.key, required this.index, required this.data}){
    titleController.text = data["name"];
    descController.text = data["mobNo"];
  }
  final int index;
  final Map<String, dynamic> data;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update page"),),
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
                  context.read<ListMapProvider>().updateData({
                    "name" : title,
                    "mobNo" : desc
                  }, index);
                  Navigator.pop(context);
                }

              }, child: Text("Update note")),
            ),
          ],
        ),
      ),
    );
  }
}
