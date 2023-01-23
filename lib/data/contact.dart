// import 'package:meta/meta.dart';

class Contact {
  String name;
  String email;
  String phoneNumber;
  bool isFavourite;

    //constructor
     Contact({ required this.name, required this.email, required this.phoneNumber, this.isFavourite = false});
}