import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/services/fipe.dart';
import 'package:fipe_mobile_app/widgets/Button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> vehicleTypes = ['carros', 'motos'];
  String selectedVehicleType = '';

  void fetchBrands () async {
    Fipe fipe = new Fipe(selectedVehicleType);
    await fipe.fetchBrands();
    if (fipe.brands.length > 0) {
      Navigator.pushNamed(context, '/brands', arguments: {
        'brands': fipe.brands
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Veículos'.toUpperCase(),
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
            Text('Selecione o tipo de veículo:'.toUpperCase()),
            SizedBox(width: 10),
            DropdownButton<String>(
                value: selectedVehicleType.isNotEmpty ? selectedVehicleType : 'carros',
                onChanged: (String newValue) => {
                  setState(() => {
                    selectedVehicleType = newValue
                  })
                },
                items: vehicleTypes.map<DropdownMenuItem<String>>((String vehicleType) => (
                    DropdownMenuItem<String>(
                      child: Text(vehicleType.toUpperCase()),
                      value: vehicleType,
                    )
                )).toList()
            ),
            SizedBox(height: 20),
            Button(disabled: selectedVehicleType.isEmpty, label: 'Buscar Marcas', onPressed: fetchBrands)
          ],
        ),
      ),
    );
  }
}
