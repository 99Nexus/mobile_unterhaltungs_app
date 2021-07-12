import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';



class MeineDateien extends StatelessWidget{
  Person user;

  MeineDateien(this.user);


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[

          SizedBox(
            width: 10
          ),
        ],

      ),
      body: Container(

      )
    );

    _generatePdfAndView(context) async{

    }
  }
}