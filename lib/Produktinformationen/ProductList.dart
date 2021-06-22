import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ProductsConstant.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>{

  ScrollController controller = ScrollController();

  List<Widget> itemsData = [];


  void getPostsData() {
    List<dynamic> responseList = DATA_FASHION;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post["brand"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${post["price"]}",
                      style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),

              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  /*@override
  void initState() {
    super.initState();
    getPostsData();
  }*/


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MyDropDownWidget(),

                  Text(
                    "Menu",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              //Bsp.
              Container(
                  height: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "T-SHIRT AMANA",
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "MbyM",
                              style: const TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "29.95",
                              style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),

                      ],
                    ),
                  )),

              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return itemsData[index];
                      })),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Neues Produkt hinzufügen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*return Scaffold(
appBar: AppBar(title: Text("Produktliste"),
),
body:
ListView(
children: <Widget>[
ListTile(
leading: Icon(Icons.shopping_bag),
title: Text("Pulli"),
),
ListTile(
leading: Icon(Icons.local_drink),
title: Text("Roku Gin"),
),
ListTile(
leading: Icon(Icons.book),
title: Text("IT'S ALL GOOD"),
),
ListTile(
leading: Icon(Icons.fastfood),
title: Text("LAKRITZ 135G WASSERMELONE ERDBEERE"),
),
ListTile(
leading: Icon(Icons.games),
title: Text("WER IM RAUM?"),
),
ListTile(
leading: Icon(Icons.add),
title: Text("Neues Produkt hinzufügen"),
),
]

)
);*/

class MyDropDownWidget extends StatefulWidget {
  const MyDropDownWidget({Key? key}) : super(key: key);

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  String dropdownValue = 'Alle';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 20,
      elevation: 14,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Alle', 'Buecher', 'Kleidung', 'Essen']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
