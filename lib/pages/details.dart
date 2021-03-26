import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/services/fipe.dart';

class Details extends StatelessWidget {
  List<VehicleDataInfo> vehicleData;

  @override
  Widget build(BuildContext context) {
    Map urlData = ModalRoute.of(context).settings.arguments;
    vehicleData = urlData['vehicleData'];

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
              itemCount: vehicleData.length,
              itemBuilder: (context, index) => (Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${vehicleData[index].label}:'),
                      Text(vehicleData[index].value.toString())
                    ],
                  ))),
        ),
      ),
    );
  }
}
