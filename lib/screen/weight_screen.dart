import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weight.dart';
import '../widget/form_deco.dart';
import '../widget/show_model.dart';
import '../provider/weight_input.dart';
import '../provider/weight_input.dart';


class WeightList extends StatefulWidget {
  const WeightList({Key? key}) : super(key: key);

  @override
  State<WeightList> createState() => _WeightListState();
}

class _WeightListState extends State<WeightList> {



  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future:Provider.of<WeightInput>(context, listen: false).getList(),
      builder: (BuildContext context, data) {
        return Scaffold(
          appBar: AppBar(title: Text("Weight Tracker"), actions: [
            IconButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed("login");
            }, icon: Icon(Icons.logout))
          ],),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showModalBottomSheet(context: context, builder: (context){
                return InputWeight(false);
              }).whenComplete(() => setState(() {
              }));
            },

            backgroundColor: Colors.yellow,
            child: Icon(Icons.add, color: Colors.black,),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: data.connectionState == ConnectionState.waiting ?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Center(child: CircularProgressIndicator(strokeWidth: 20,)),
              )  :
              Column(
                children: Provider.of<WeightInput>(context, listen: false).weights.map((e){
                  return  ListTile(
                      title: Text(e.weight.toString()+ " " + "kg") ,

                      trailing: Container(
                        width: 102,
                        child: Row(
                          children: [
                            IconButton(onPressed: () {

                              showModalBottomSheet(context: context, builder: (context){
                                return InputWeight(true, e.id);
                              }).whenComplete(() => setState(() {}));



                            }, icon: Icon(Icons.edit)),
                            IconButton(onPressed: ()  {
                               Provider.of<WeightInput>(context, listen: false).deleteweight(e.id)
                                   .then((value) =>setState(() {})
                               );


                            }, icon: Icon(Icons.delete))
                          ],
                        ),
                      )
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },

    );
  }
}

