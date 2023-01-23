import 'package:flutter/material.dart';

import 'UI/contacts_list/contacts_list_page.dart';

void main()=>{
  runApp(MyApp())
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: ContactsListPage()
    );
  }
}

