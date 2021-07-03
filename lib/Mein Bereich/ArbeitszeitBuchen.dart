import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/text_field.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/Attendance.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';


final calentyRef = FirebaseFirestore.instance.collection('calenderentry').withConverter(
    fromFirestore: (snapshots, _) => CalenderEntry.fromJson(snapshots.data()!),
    toFirestore: (calenderentry, _) => calenderentry.toJson());



/// This is the main application widget.
class ArbeitszeitErfassen extends StatelessWidget {
  const ArbeitszeitErfassen({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'app',
      title: _title,
      home: MyStatefulWidget(restorationId: 'main'),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// RestorationProperty objects can be used because of RestorationMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021, 1, 1),
          lastDate: DateTime(2022, 1, 1),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Future<void> update() async{
      final CalenderEntry = await calentyRef.get();
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for(final entry in CalenderEntry.docs)
        {
          batch.update(entry.reference, {'attendance': Attendance(
              true, DateTime(2021, 07, 06, 10, 00),
              DateTime(2021, 07, 06, 15, 00))});
        }
      await batch.commit();
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Arbeitszeit buchen'
          )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
          children: [
            Title(color: Colors.black,
             child: Text(
               'Datum'
             ),
            ),
          OutlinedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('Start auswählen')
          ),
          OutlinedButton(
              onPressed: () {
                _restorableDatePickerRouteFuture.present();
              },
              child: const Text('Ende auswählen')
          ),
          ]
          ),
          Container(
            width: 200.0,
            child: TextField(
            obscureText: false,
              textAlign: TextAlign.justify,
            style: TextStyle(
            fontSize: 15.0,
            height: 1.5,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Arbeitsstunden eintragen',
            ),
          ),
          ),
          Container(
            width: 200.0,
            child: TextField(
              maxLines: 5,
              maxLength: 120,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15.0,
                height: 2.5,
           ),
              decoration: InputDecoration(
                hintText: 'Tätigkeit eintragen',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () {Navigator.pop(context);}, //TODO Pop funktioniert nicht richtig
                child: Text('Löschen'),
              ),
              SizedBox(width: 25),
              RaisedButton(
                onPressed: () {update();},
                child: Text('Speichern'),
              )
            ],
          )
        ],
        ),

      );
  }
}