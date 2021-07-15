
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductDetails.dart';
import 'Product.dart';
import 'search_widget.dart';
import 'ProductAdding.dart';


final productentryRef = FirebaseFirestore.instance
    .collection('articles')
    .withConverter(
    fromFirestore: (snapshots, _) =>
        Product.fromJson(snapshots.data()!),
    toFirestore: (articles, _) => articles.toJson());



class ProductList extends StatefulWidget {

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>{

  ScrollController controller = ScrollController();

 late List itemsData;
  String query = '';
  List<Product> searchItems = [];



  late Query<Product> _productQuery;

  late Stream<QuerySnapshot<Product>> _products;

  @override
  void initState() {
    super.initState();
    //getPostsData();
    _updateProductQuery();
    searchItems.add(new Product('Produktname', 0.00, 'Produktbeschreibung', 'Kategorie', 'Marke'));
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
    double width = MediaQuery.of(context).size.width;
    double ourwidth = width*0.5;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Text(
                    "Produktliste",
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

                  //Alle Artikel in die Suchliste hinzfügen
                  for(int i = 0; i<data.docs.length; i++){
                    this.searchItems.add(data.docs[i].data());
                  }
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
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      '${itemsData[index].data().category}',
                                      //'${data.docs[index].data().category}',
                                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${itemsData[index].data().price}€',
                                          //'${data.docs[index].data().price}',
                                          style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 20,),
                                        TextButton(
                                            onPressed: () => Navigator.push(context,
                                                MaterialPageRoute(builder: (_) => ProductDetails(data.docs[index].data()))),
                                            child: const Text(
                                              'mehr Anzeigen',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 104, 18, 18),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            )
                                        ),
                                      ],
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_) =>
              ProductAdding()));
          },
          backgroundColor: Color.fromARGB(255, 104, 18, 18),
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
  void searchProduct(String query) async {

    final itemsdata = searchItems.where((element) {
      final pNameLower = element.productname.toLowerCase();
      final searchLower = query.toLowerCase();

      return pNameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.itemsData=itemsData;
    });

  }

}
