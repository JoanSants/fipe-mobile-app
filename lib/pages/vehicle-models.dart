import 'package:fipe_mobile_app/services/fipe.dart';
import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/widgets/Button.dart';

class VehicleModels extends StatefulWidget {
  @override
  _VehicleModelsState createState() => _VehicleModelsState();
}

class _VehicleModelsState extends State<VehicleModels> {
  Map urlData = {};
  String selectedModel = '';
  String selectedYear = '';
  List<Year> vehicleYears = [];
  VehicleModelsData vehicleModelsData;
  int vehicleCode;

  void fetchVehicleYear() async {
    Fipe fipe = Fipe(
        brandCode: urlData['brandCode'],
        vehicleType: urlData['vehicleType'],
        vehicleCode: vehicleCode);
    await fipe.fetchVehicleYear();
    setState(() {
      vehicleYears = fipe.years;
    });
  }

  void fetchVehicleData() async {
    Fipe fipe = Fipe(
        brandCode: urlData['brandCode'],
        vehicleType: urlData['vehicleType'],
        vehicleCode: vehicleCode,
        yearCode:
            vehicleYears.firstWhere((year) => year.name == selectedYear).code);
    await fipe.fetchVehicleData();

    Navigator.pushNamed(context, '/details',
        arguments: {'vehicleData': fipe.vehicleData});
  }

  @override
  Widget build(BuildContext context) {
    urlData = ModalRoute.of(context).settings.arguments;
    vehicleModelsData = urlData['vehicleModelsData'];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Modelos'.toUpperCase(),
            style: TextStyle(letterSpacing: 8),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selectione o modelo:'.toUpperCase()),
              DropdownButton(
                value: selectedModel.isNotEmpty
                    ? selectedModel
                    : vehicleModelsData.vehicleModels[0].name,
                items: vehicleModelsData.vehicleModels
                    .map((model) => (DropdownMenuItem(
                        child: Text(model.name), value: model.name)))
                    .toList(),
                onChanged: (String newValue) => {
                  setState(() => {
                        selectedModel = newValue,
                        vehicleYears = [],
                        vehicleCode = vehicleModelsData.vehicleModels
                            .firstWhere((model) => model.name == selectedModel)
                            .code
                      })
                },
              ),
              SizedBox(height: 20),
              if (vehicleYears.length > 0)
                (Text('Selectione o ano:'.toUpperCase())),
              if (vehicleYears.length > 0)
                (DropdownButton(
                  value: selectedYear.isNotEmpty
                      ? selectedYear
                      : vehicleYears[0].name.toString(),
                  items: vehicleYears
                      .map((ano) => (DropdownMenuItem(
                          child: Text(ano.name), value: ano.name)))
                      .toList(),
                  onChanged: (String newValue) => {
                    setState(() => {selectedYear = newValue})
                  },
                )),
              if (vehicleYears.length == 0)
                (Button(
                    label: 'Buscar anos'.toUpperCase(),
                    disabled: selectedModel.isEmpty,
                    onPressed: fetchVehicleYear)),
              if (vehicleYears.length > 0)
                (Button(
                    label: 'Buscar informações'.toUpperCase(),
                    disabled: selectedYear.isEmpty,
                    onPressed: fetchVehicleData))
            ],
          ),
        ));
  }
}
