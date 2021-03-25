import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/services/fipe.dart';

class Details extends StatelessWidget {
  Fipe fipe;

  @override
  Widget build(BuildContext context) {
    Map urlData = ModalRoute.of(context).settings.arguments;
    Fipe fipe = urlData['globalFipe'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detalhes'.toUpperCase(),
          style: TextStyle(letterSpacing: 8),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: fipe.vehicleData.length,
              itemBuilder: (context, index) => (Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${fipe.vehicleData[index].label}:'),
                      Text(fipe.vehicleData[index].value.toString())
                    ],
                  ))),
        ),
      ),
    );
  }
}
