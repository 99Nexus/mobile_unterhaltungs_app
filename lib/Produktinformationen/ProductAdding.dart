import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'Product.dart';
import 'ProductList.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';

final usersCollection = FirebaseFirestore.instance
    .collection('articles')
    .withConverter(
    fromFirestore: (snapshots, _) => Product.fromJson(snapshots.data()!),
    toFirestore: (person, _) => person.toJson());

final CollectionReference positionCollection = FirebaseFirestore.instance.collection('articles');

class ProductAdding extends StatefulWidget {
  @override
  ProductAddingState createState() => ProductAddingState();
}

class ProductAddingState extends State<ProductAdding> {

  final productnameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final brandController = TextEditingController();

  String errorTextProductname = ' ';
  String errorTextPrice = ' ';
  String errorTextDescription = ' ';
  String errorTextCategory = ' ';
  String errorTextBrand = ' ';

  Product p = new Product("", 0, "", "", "");

  bool inputValid = false;

  AuthController authController = new AuthController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Produktanlegen",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              child: Text(
                'Titel',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Produktname',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField (
                controller: productnameController,
                textAlign: TextAlign.center,
                cursorColor: Color.fromARGB(255, 104, 18, 18),
                maxLines: 1,
                maxLength: 30,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: OutlineInputBorder(),
                  counterText: errorTextProductname,
                  counterStyle: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Preis',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField (
                controller: priceController,
                textAlign: TextAlign.center,
                cursorColor: Color.fromARGB(255, 104, 18, 18),
                maxLines: 1,
                maxLength: 30,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: OutlineInputBorder(),
                  counterText: errorTextPrice,
                  counterStyle: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Produktbeschreibung',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField (
                controller: descriptionController,
                textAlign: TextAlign.center,
                cursorColor: Color.fromARGB(255, 104, 18, 18),
                maxLines: 1,
                maxLength: 30,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: OutlineInputBorder(),
                  counterText: errorTextDescription,
                  counterStyle: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Kategorie',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField (
                controller: categoryController,
                textAlign: TextAlign.center,
                cursorColor: Color.fromARGB(255, 104, 18, 18),
                maxLines: 1,
                maxLength: 30,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: OutlineInputBorder(),
                  counterText: errorTextCategory,
                  counterStyle: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                'Marke',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10.0),
              child: TextField (
                controller: brandController,
                textAlign: TextAlign.center,
                cursorColor: Color.fromARGB(255, 104, 18, 18),
                maxLines: 1,
                maxLength: 30,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  border: OutlineInputBorder(),
                  counterText: errorTextBrand,
                  counterStyle: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: (MediaQuery.of(context).size.width*0.4)*0.6,
              padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 104, 18, 18),
                  ),
                  child: Text('Anlegen'),
                  onPressed: () async {

                    setState(() {

                      p = new Product(productnameController.text, double.parse(priceController.text),
                          descriptionController.text,
                          categoryController.text,
                          brandController.text);
                      saveProductInCollection();
                      Navigator.pop(context);
                    });
                  }
              ),
            )
          ],
        ),
      ),
    );

  }

  void saveProductInCollection() {

    int productID = 0;

    setState(() {

      // Aktuellste ProduktID holen
          usersCollection
              .get()
              .then((snapshot) => {

            // ProduktID aktualisieren, falls bereits Produkt vorhanden sind
            // Sonst als erste ID "0" verwenden
            // Hinweis: snapshot.size speichert die Länge der Collection
            if(snapshot.size > 0)
              productID = snapshot.size,

            // Produkt in Datenbank hinzufügen
            // Hinweis: Funktion befindet sich in "then"-Abschnitt, da das Hinzufügen
            // erst nach Ermittlung der aktuellen ProduktID
            // ausgeführt werden soll
            usersCollection.doc(productID.toString())
                .set(Product(productnameController.text,
                double.parse(priceController.text),
                descriptionController.text,
                categoryController.text,
                brandController.text)),
          });
        });
      }

}