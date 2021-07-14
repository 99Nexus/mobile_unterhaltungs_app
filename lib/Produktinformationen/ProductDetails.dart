import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/Product.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';

class ProductDetails extends StatelessWidget {

  Product p;

  ProductDetails(this.p);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/teaser-unterhaltung.png',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 80,
      ),
      body: Column(
        children: [
          //ElevatedButton(onPressed: , child: Text('Zurück')),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(color: Color.fromARGB(
            255, 104, 18, 18),),
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
          child:Text(
            '${p.productname}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,

            ),

          ),
        ),
          Container(
            height: 40,
            decoration: BoxDecoration(color: Color.fromARGB(
                255, 104, 18, 18), border: Border.all(color: Colors.black,)),
            margin: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[

                Text(
                  '${p.brand}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                Text(
                  '${p.price}€',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
          child: Text(
            '${p.description}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
            ),
        ],
      ),
    );
  }



}