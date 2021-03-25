import 'package:http/http.dart' as http;
import 'dart:convert';



class Brand {
  String nome = '';
  String codigo = '';

  Brand({ this.nome, this.codigo });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      codigo: json['codigo'],
      nome: json['nome']
    );
  }
}

class Fipe {
  String vehicleType = '';
  List<Brand> brands = [];

  Fipe(this.vehicleType);

  Future<void> fetchBrands () async {
    http.Response response = await http.get(Uri.https('parallelum.com.br', '/fipe/api/v1/${this.vehicleType}/marcas'));
    List<dynamic> fetchedBrands = jsonDecode(response.body);
    brands = fetchedBrands.map((brand) => Brand.fromJson(brand)).toList();
  }
}