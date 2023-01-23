// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/contact.dart';

class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  late List<Contact> _contacts;
    String pText = "";
    String dateController = "";
    late File imageFile;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contacts = List.generate(50, (index) {
      return Contact(
          name: "${faker.person.firstName()} ${faker.person.lastName()}",
          email: faker.internet.email(),
          phoneNumber: faker.randomGenerator.integer(1000000).toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Contacts"),
            centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(accountName: Text("Gideon Nti Boateng", style: TextStyle(fontSize: 25),), accountEmail: Text("gideon.boateng@amalitech.com", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),), currentAccountPicture: CircleAvatar(backgroundColor: Colors.blueGrey,child: Text(("GNB")),

              ),),
              ListTile(title: Text('Phone', style: TextStyle(fontSize: 20),),subtitle: Text(pText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), trailing: Icon(Icons.phone_android, size: 40, color: Colors.greenAccent), onTap: (){
                showDialog(context: context, builder: (context)=> AlertDialog(
                  title: Text("Enter Phone Number"),
                  content: TextField(onChanged: (String txt){
                    setState(() {
                      pText = txt;
                    });
                  },),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Save")),
                    TextButton(onPressed: (){
                     setState(() {
                       pText = "";
                     });
                      Navigator.pop(context);
                    }, child: Text("Cancel"))

                  ],
                ));
              },),
              ListTile(title: Text('Birthday', style: TextStyle(fontSize: 20)), subtitle: Text('May, 7', style: TextStyle(color: Colors.white, fontSize: 18),), trailing: Icon(Icons.calendar_month_sharp,size: 40, color: Colors.greenAccent,),
              onTap: (){
                showDialog(context: context, builder: (context)=> DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2050)));
              },
              ),
              ListTile(title: Text('Close', style: TextStyle(fontSize: 23),), trailing: Icon(Icons.close, color: Colors.redAccent, size: 33,), onTap: (){Navigator.pop(context);},),
              TextButton(onPressed: (){
                _getFromCamera();
              }, child: Text("Choose Image"))

            ],
          )
        ),
        body: ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
                  _contacts[index].name,
                  style: TextStyle(fontSize: 22),
                ),
                subtitle: Text(
                  _contacts[index].email,
                  style: TextStyle(color: Colors.blueGrey),
                ), trailing: IconButton(
                onPressed: (){
                  setState(() {
                    _contacts[index].isFavourite =! _contacts[index].isFavourite;
                    _contacts.sort((a,b){
                      if(a.isFavourite){
                        return -1;
                      }else if(b.isFavourite){
                        return 1;
                      }else{
                        return 0;
                      }
                    });
                  });

                },
                icon: Icon(
                  _contacts[index].isFavourite ? Icons.favorite : Icons.favorite_outline,
                    color: _contacts[index].isFavourite ? Colors.orange : Colors.grey
                )

            ));
          },
        ));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    )) as PickedFile?;
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}





