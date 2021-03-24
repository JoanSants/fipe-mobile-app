import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> vehicleTypes = ['carros', 'motos'];
  String vehicleDropDownValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tabela Fipe'.toUpperCase(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selecione o tipo de veículo:'.toUpperCase()),
                SizedBox(width: 10),
                DropdownButton<String>(
                    value: vehicleDropDownValue.isNotEmpty ? vehicleDropDownValue : 'carros',
                    onChanged: (String newValue) => {
                      setState(() => {
                        vehicleDropDownValue = newValue
                      })
                    },
                    items: vehicleTypes.map<DropdownMenuItem<String>>((String vehicleType) => (
                        DropdownMenuItem<String>(
                          child: Text(vehicleType.toUpperCase()),
                          value: vehicleType,
                        )
                    )).toList()
                ),
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('Buscar'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      vehicleDropDownValue.isNotEmpty ?
                      Theme.of(context).primaryColor :
                      Theme.of(context).disabledColor
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
