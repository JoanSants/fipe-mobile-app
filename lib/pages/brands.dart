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

  @override
  Widget build(BuildContext context) {
    urlData = ModalRoute.of(context).settings.arguments;
    brands = urlData['brands'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Marcas'.toUpperCase(),
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
            Text('Selecione a marca desejada:'),
            DropdownButton<String>(
                value: selectedBrandName.isNotEmpty ? selectedBrandName : brands[0].nome,
                onChanged: (String newValue) => {
                  setState(() => {
                    selectedBrandName = newValue
                  })
                },
                items: brands.map<DropdownMenuItem<String>>((brand) => (
                    DropdownMenuItem<String>(
                      child: Text(brand.nome),
                      value: brand.nome,
                    )
                )).toList()
            ),
            SizedBox(height: 20),
            Button(disabled: selectedBrandName.isEmpty, label: 'Buscar Modelos')
          ],
        ),
      ),
    );
  }
}
