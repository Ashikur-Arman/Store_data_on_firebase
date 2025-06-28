import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'display_data_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // for text editor Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController professionController = TextEditingController();


  final CollectionReference myItems = FirebaseFirestore.instance.collection("Store Data");  // collecting name

  Future<void> storeData() async {
    return showDialog(
        context: context,
        builder: (BuildContext context){
      return myDialogBox(context: context, onPressed: (){
        String name = nameController.text;
        String address = addressController.text;
        String profession = professionController.text;

        myItems.add({
          'name': name,
          'position': address,
          'proffesion': profession,
        });
        Navigator.pop(context);  // terminate the dialog after storing the items

      });
     },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Hello"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: storeData,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DisplayDataScreen()),
            );
          },
          child: const Text(
            "Go to Data Page",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
  Dialog myDialogBox({
    required BuildContext context,
    required VoidCallback onPressed,})
  {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          // height: 150, // ✅ give fixed height
          // width: 300,  // ✅ give fixed width
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Store data from users",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                   ),
                 ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.close))
                ],
              ),
              commonTextField("eg. Arman","Enter your name",nameController),
              commonTextField("eg. Ban","Enter your address",addressController),
              commonTextField("eg. Dev","Enter your position",professionController),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: onPressed,
                child: Text("Store",style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10,),
            ],
            ),
          ),
        ),
      );
    }
    Padding  commonTextField(hint, label,controller){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blue,width: 2
          ),
        ),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black,width: 2
          ),
        ),
      ),
      ),
     );

    }
}


