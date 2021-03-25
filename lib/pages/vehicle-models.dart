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

  void fetchModelInfo () {

  }

  @override
  Widget build(BuildContext context) {
    urlData = ModalRoute.of(context).settings.arguments;
    VehicleModelsData vehicleModelsData = urlData['vehicleModelsData'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Modelos'.toUpperCase(),
          style: TextStyle(
            letterSpacing: 8
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selectione o modelo:'.toUpperCase()),
            DropdownButton(
              value: selectedModel.isNotEmpty ? selectedModel : vehicleModelsData.modelos[0].nome,
              items: vehicleModelsData.modelos.map((model) => (
                DropdownMenuItem(
                    child: Text(model.nome),
                    value: model.nome
                )
              )).toList(),
              onChanged: (String newValue) => {
                setState(() => {
                  selectedModel = newValue
                })
              },
            ),
            SizedBox(height: 20),
            Text('Selectione o ano:'.toUpperCase()),
            DropdownButton(
              value: selectedYear.isNotEmpty ? selectedYear : vehicleModelsData.anos[0].nome,
              items: vehicleModelsData.anos.map((ano) => (
                  DropdownMenuItem(
                      child: Text(ano.nome),
                      value: ano.nome
                  )
              )).toList(),
              onChanged: (String newValue) => {
                setState(() => {
                  selectedYear = newValue
                })
              },
            ),
            Button(label: 'Buscar informações'.toUpperCase(), disabled: selectedModel.isEmpty || selectedYear.isEmpty, onPressed: fetchModelInfo)
          ],
        ),
      )
    );
  }
}
