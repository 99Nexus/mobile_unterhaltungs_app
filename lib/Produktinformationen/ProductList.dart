import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Product.dart';
import 'search_widget.dart';
import 'package:table_calendar/table_calendar.dart';

final productentryRef = FirebaseFirestore.instance
    .collection('test')
    .withConverter(
    fromFirestore: (snapshots, _) =>
        Product.fromJson(snapshots.data()!),
    toFirestore: (test, _) => test.toJson());

class ProductList extends StatefulWidget {

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>{

  ScrollController controller = ScrollController();

 late List itemsData;
  String query = '';

  late Query<Product> _productQuery;

  late Stream<QuerySnapshot<Product>> _products;


  @override
  void initState() {
    super.initState();
    //getPostsData();
    _updateProductQuery();
  }



  void _updateProductQuery(){
    setState(() {
      _productQuery = productentryRef;
      _products = _productQuery.snapshots();
    });
  }




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
            buildSearch(),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Product>>(
                stream: _products,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;
                  itemsData = snapshot.requireData.docs;
                  return ListView.builder(
                    itemCount: itemsData.length,
                    itemBuilder: (context, index) {

                        return Container(
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
                                      Expanded(
                                        child: Text(
                                          '${itemsData[index].data().productname}',
                                          //'${data.docs[index].data().productname}',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${data.docs[index].data().category}',
                                        style: const TextStyle(fontSize: 17, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${data.docs[index].data().price}',
                                        style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  //ElevatedButton(onPressed: onPressed, child: child)

                                ],
                              ),
                            ),

                        );


                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }


  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Produkt- oder Markenname eingeben',
    onChanged: searchProduct,
  );

  //TODO: Funktionerende Suche
  void searchProduct(String query) {
    CollectionReference productCollection = FirebaseFirestore.instance.collection('test');
    final products = productCollection.where('productname', isEqualTo: query);

    setState(() {
      this.query = query;
      this.itemsData = products as List;
    });
  }

}


class MyDropDownWidget extends StatefulWidget {
  const MyDropDownWidget({Key? key}) : super(key: key);

  @override
  State<MyDropDownWidget> createState() => _MyDropDownWidgetState();
}

class _MyDropDownWidgetState extends State<MyDropDownWidget> {
  String dropdownValue = 'ALLE';

  String getddv(){
    return this.dropdownValue;
  }

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
      items: <String>['ALLE', 'BUECHER', 'KLEIDUNG', 'ESSEN']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

















/*void getPostsData() {

    //List<dynamic> responseList = DATA_ALL;
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
                    Expanded(
                      child: Text(
                        post["name:"],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
  }*/

  /*child: ListView.builder(

                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return itemsData[index];
                      })),*/
  /*ListTile(
  leading: Icon(Icons.add),
  title: Text("Neues Produkt hinzufügen"),
  ),*/