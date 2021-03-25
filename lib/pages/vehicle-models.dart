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
  List<Ano> vehicleYears = [];

  @override
  Widget build(BuildContext context) {
    urlData = ModalRoute.of(context).settings.arguments;
    VehicleModelsData vehicleModelsData = urlData['vehicleModelsData'];

    void fetchVehicleYear () async {
      Fipe fipe = Fipe(brandCode: urlData['brandCode'], vehicleType: urlData['vehicleType'], vehicleCode: vehicleModelsData.modelos.firstWhere((model) => model.nome == selectedModel).codigo);
      await fipe.fetchVehicleYear();
      setState(() {
        vehicleYears = fipe.years;
      });
    }

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
                  selectedModel = newValue,
                  vehicleYears = []
                })
              },
            ),
            SizedBox(height: 20),
            if (vehicleYears.length > 0) (
                Text('Selectione o ano:'.toUpperCase())
            ),
            if (vehicleYears.length > 0) (
                DropdownButton(
                  value: selectedYear.isNotEmpty ? selectedYear : vehicleYears[0].nome.toString(),
                  items: vehicleYears.map((ano) => (
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
                )
            ),
            Button(label: 'Buscar anos'.toUpperCase(), disabled: selectedModel.isEmpty || selectedYear.isEmpty, onPressed: fetchVehicleYear)
          ],
        ),
      )
    );
  }
}
