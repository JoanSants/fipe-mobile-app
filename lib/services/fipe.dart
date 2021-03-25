import 'package:http/http.dart' as http;
import 'dart:convert';

class Brand {
  String nome = '';
  String codigo = '';

  Brand({ this.nome, this.codigo });
}

class Ano {
  String nome;
  String codigo;

  Ano({ this.nome, this.codigo });
}

class Modelo {
  String nome;
  int codigo;

  Modelo({ this.nome, this.codigo });
}

class VehicleModelsData {
  List<Ano> anos = [];
  List<Modelo> modelos = [];

  VehicleModelsData({ this.anos, this.modelos });
}

class Fipe {
  String vehicleType = '';
  String brandCode = '';
  List<Brand> brands = [];
  VehicleModelsData vehicleModelsData;
  int vehicleCode = 0;
  List<Ano> years = [];

  Fipe({ this.vehicleType, this.brandCode, this.vehicleCode });

  Future<void> fetchBrands () async {
    http.Response response = await http.get(Uri.https('parallelum.com.br', '/fipe/api/v1/${this.vehicleType}/marcas'));
    List<dynamic> fetchedBrands = jsonDecode(response.body);
    brands = fetchedBrands.map((brand) => Brand(nome: brand['nome'], codigo: brand['codigo'])).toList();
  }
  
  Future<void> fetchVehicleModelsData () async {
    http.Response response = await http.get(Uri.https('parallelum.com.br', '/fipe/api/v1/${vehicleType}/marcas/${brandCode}/modelos'));
    Map<String, dynamic> vehicleData = jsonDecode(response.body);
    List<Ano> anos = (vehicleData['anos'] as List).map((ano) => Ano(nome: ano['nome'], codigo: ano['codigo'])).toList();
    List<Modelo> modelos = (vehicleData['modelos'] as List).map((modelo) => Modelo(nome: modelo['nome'], codigo: modelo['codigo'])).toList();
    vehicleModelsData = VehicleModelsData(anos: anos, modelos: modelos);
  }

  Future<void> fetchVehicleYear () async {
    http.Response response = await http.get(Uri.https('parallelum.com.br', '/fipe/api/v1/${vehicleType}/marcas/${brandCode}/modelos/${vehicleCode}/anos'));
    List<dynamic> json = jsonDecode(response.body);
    years = json.map((year) => Ano(nome: year['nome'], codigo: year['codigo'])).toList();
  }
}