import 'package:flutter/material.dart';
import 'package:fipe_mobile_app/services/fipe.dart';
import 'package:fipe_mobile_app/widgets/Button.dart';

class Brands extends StatefulWidget {
  @override
  _BrandsState createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  Map urlData = {};
  List<Brand> brands = [];
  String selectedBrandName = '';
  String vehicleType = '';

  void fetchBrandVehicles() async {
    Fipe fipe = new Fipe(
        brandCode:
            brands.firstWhere((brand) => brand.name == selectedBrandName).code,
        vehicleType: vehicleType);
    await fipe.fetchBrandVehicles();

    Navigator.pushNamed(context, '/models', arguments: {
      'brandCode': fipe.brandCode,
      'vehicleModelsData': fipe.vehicleModelsData,
      'vehicleType': vehicleType
    });
  }

  @override
  Widget build(BuildContext context) {
    urlData = ModalRoute.of(context).settings.arguments;
    brands = urlData['brands'];
    vehicleType = urlData['vehicleType'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Marcas'.toUpperCase(),
          style: TextStyle(letterSpacing: 8),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selecione a marca:'.toUpperCase()),
            DropdownButton<String>(
                value: selectedBrandName.isNotEmpty
                    ? selectedBrandName
                    : brands[0].name,
                onChanged: (String newValue) => {
                      setState(() => {selectedBrandName = newValue})
                    },
                items: brands
                    .map<DropdownMenuItem<String>>(
                        (brand) => (DropdownMenuItem<String>(
                              child: Text(brand.name),
                              value: brand.name,
                            )))
                    .toList()),
            SizedBox(height: 20),
            Button(
                disabled: selectedBrandName.isEmpty,
                label: 'Buscar Modelos',
                onPressed: fetchBrandVehicles)
          ],
        ),
      ),
    );
  }
}
