import 'package:flutter/material.dart';
import '../widget/form_deco.dart';
import '../models/weight.dart';
import 'package:provider/provider.dart';
import '../provider/weight_input.dart';


class InputWeight extends StatefulWidget {

  bool is_edit = true;
  late String id;
  InputWeight(this.is_edit, [this.id=""]);

  @override
  State<InputWeight> createState() => _InputWeightState();
}

class _InputWeightState extends State<InputWeight> {

  late double myweight;

  final key = GlobalKey<FormState>();

  void submitit() {

    if(!key.currentState!.validate()) {
      return;
    }

    key.currentState!.save();



    widget.is_edit ? Provider.of<WeightInput>(context, listen: false)
        .editweight(widget.id, myweight)
        : Provider.of<WeightInput>(context, listen: false)
        .add_list(myweight);

    setState(() {

    });

    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if(value!.isEmpty || value ==null) {
                            return 'Enter your weight please';
                          }
                        },
                        onSaved: (value){
                          myweight = double.parse(value!);


                        },
                        decoration:decory
                    ),
                  ),
                ),

              ),
              TextButton(
                  onPressed: (){
                    submitit();

                  },

                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    child: Center(child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 20),)),
                  )
              )
            ],

          ),
        ),
      ),
    );
  }
}
