import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/providerpractice/add_page.dart';
import 'package:wsdtabse/providerpractice/update_page.dart';
import 'package:wsdtabse/providerpractice/list_map_provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List page"),
      ),
      body: Consumer<ListMapProvider>(
          builder: (ctx, provider, __){
            var fetchAllData = provider.fetchData();
            return fetchAllData.isNotEmpty ? ListView.builder(
                itemCount: fetchAllData.length,
                itemBuilder: (_, index){
              return ListTile(
                leading: Text("${(index + 1).toString()}"),
                title: Text(fetchAllData[index]["name"]),
                subtitle: Text(fetchAllData[index]["mobNo"]),
                trailing: Container(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap:(){
                        var item = fetchAllData[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage(isUpdate: true,
                          index: index, title: fetchAllData[index]["name"],desc: fetchAllData[index]["mobNo"],
                        )));
                      }, child: Icon(Icons.edit_outlined)),
                      InkWell(onTap:(){
                        context.read<ListMapProvider>().deleteData(index);
                      }, child: Icon(Icons.delete_outline)),
                    ],
                  ),
                ),
              );
            })
                : Center(child: Text("No data"),);
          }
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
      }, child: Icon(Icons.add),),
    );
  }
}
