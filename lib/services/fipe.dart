import 'package:http/http.dart' as http;
import 'dart:convert';

class Brand {
  String name = '';
  String code = '';

  Brand({this.name, this.code});
}

class Year {
  String name;
  String code;

  Year({this.name, this.code});
}

class VehicleModel {
  String name;
  int code;

  VehicleModel({this.name, this.code});
}

class VehicleModelsData {
  List<VehicleModel> vehicleModels = [];

  VehicleModelsData({this.vehicleModels});
}

class VehicleDataInfo {
  String label;
  String value;

  VehicleDataInfo({this.label, this.value});
}

class Fipe {
  String vehicleType = '';
  String brandCode = '';
  List<Brand> brands = [];
  VehicleModelsData vehicleModelsData;
  int vehicleCode = 0;
  List<Year> years = [];
  String yearCode = '';
  List<VehicleDataInfo> vehicleData;

  Fipe({this.vehicleType, this.brandCode, this.vehicleCode, this.yearCode});

  Future<void> fetchBrands() async {
    http.Response response = await http.get(Uri.https(
        'parallelum.com.br', '/fipe/api/v1/${this.vehicleType}/marcas'));
    List<dynamic> fetchedBrands = jsonDecode(response.body);
    brands = fetchedBrands
        .map((brand) => Brand(name: brand['nome'], code: brand['codigo']))
        .toList();
  }

  Future<void> fetchBrandVehicles() async {
    http.Response response = await http.get(Uri.https('parallelum.com.br',
        '/fipe/api/v1/${vehicleType}/marcas/${brandCode}/modelos'));
    Map<String, dynamic> brandVehicles = jsonDecode(response.body);
    List<VehicleModel> vehicleModels = (brandVehicles['modelos'] as List)
        .map((modelo) =>
            VehicleModel(name: modelo['nome'], code: modelo['codigo']))
        .toList();
    vehicleModelsData = VehicleModelsData(vehicleModels: vehicleModels);
  }

  Future<void> fetchVehicleYear() async {
    http.Response response = await http.get(Uri.https('parallelum.com.br',
        '/fipe/api/v1/${vehicleType}/marcas/${brandCode}/modelos/${vehicleCode}/anos'));
    List<dynamic> vehicleYears = jsonDecode(response.body);
    years = vehicleYears
        .map((year) => Year(name: year['nome'], code: year['codigo']))
        .toList();
  }

  // GET: https://

  Future<void> fetchVehicleData() async {
    http.Response response = await http.get(Uri.https('parallelum.com.br',
        '/fipe/api/v1/${vehicleType}/marcas/${brandCode}/modelos/${vehicleCode}/anos/${yearCode}'));
    Map<String, dynamic> json = jsonDecode(response.body);
    vehicleData = [
      VehicleDataInfo(label: 'Valor', value: json['Valor']),
      VehicleDataInfo(label: 'Marca', value: json['Marca']),
      VehicleDataInfo(label: 'Modelo', value: json['Modelo']),
      VehicleDataInfo(label: 'Ano', value: json['AnoModelo'].toString()),
      VehicleDataInfo(label: 'Combustível', value: json['Combustivel']),
      VehicleDataInfo(label: 'Código Fipe', value: json['CodigoFipe']),
      VehicleDataInfo(label: 'Mês Referência', value: json['MesReferencia']),
    ];
  }
}
