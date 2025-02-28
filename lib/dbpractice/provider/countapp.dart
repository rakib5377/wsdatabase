import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsdtabse/dbpractice/provider/counterprovider.dart';
class Countapp extends StatelessWidget {
  const Countapp({super.key});

  @override
  Widget build(BuildContext context) {
    print("buld caleed");
    return Scaffold(
      appBar: AppBar(title: Text("Count with provider"),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (ctx, _, __) {
                      print("Consumer build called");
                      return Text("Pressed "
                          //"${Provider.of<CounterProvider>(ctx).getCount()} "
                          "${ctx.watch<CounterProvider>().getCount()} "
                          "times");
                    },
                  ),
                ],
              ),
              SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    //Provider.of<CounterProvider>(context,listen: false).increment(5);
                    context.read<CounterProvider>().increment(5);
                  }, child: Text("Increment")),
                  ElevatedButton(onPressed: (){
                    context.read<CounterProvider>().decrement(10);
                  }, child: Text("Decrement"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
