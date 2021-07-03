import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/text_field.dart';



/// This is the main application widget.
class UrlaubBeantragen extends StatelessWidget {

  UrlaubBeantragen();

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
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Urlaub buchen'
          )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
            Align(
              alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
              child: Text(
                  "Gebuchte Urlaubstage: ",
                style: TextStyle(
                  fontSize: 18.0,
                )
              ),
            ),

              Align(
                alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                child: Text(
                    "Verfügbare Urlaubstage: ",
                  style: TextStyle(
                    fontSize: 18.0,
                )
              ),
            ),
          ]),
          Column(
            children: [
          OutlinedButton(
              onPressed: () {
                _restorableDatePickerRouteFuture.present();
              },
              child: const Text('Urlaubsstart auswählen')
          ),
          OutlinedButton(
              onPressed: () {
                _restorableDatePickerRouteFuture.present();
              },
              child: const Text('Urlaubsende auswählen'),
          ),
          ],
          ),

          Align(
            alignment: Alignment.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Positioned(
                bottom: 0.0,
                child: RaisedButton(
                onPressed: () {Navigator.pop(context);},  //TODO Pop funktioniert nicht richtig
                child: Text('Löschen'),
              ),
              ),
              SizedBox(width: 25),
              RaisedButton(
                onPressed: () {},
                child: Text('Speichern'),
              )
            ],
          )
        ],
      ),

    );
  }
}