import 'package:flutter/material.dart';
import 'login/login.dart';

void main(){
  runApp(
    MaterialApp(
      home: Login(),
      theme: ThemeData(
        
        primaryColor: Colors.white,
        fontFamily: "Montserrat",
        
      ),
    ),
  );
}

