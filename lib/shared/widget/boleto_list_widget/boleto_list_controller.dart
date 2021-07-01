import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  //Usa o ValueNotifier, atribuindo valor de uma lista de BoletoModel vazia
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);

  //se buscar os valores de boletos (controler.boletos),
  //busca os valores do notifier
  List<BoletoModel> get boletos => boletosNotifier.value;

  //Se for atribuir um valor ao boleto (controler(boleto:boleto))
  //manda direto pro notifier
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  //Assim que for instanciada o controller, já faz a busca dos boletos
  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final instace = await SharedPreferences.getInstance();
      //Busca no sharedPreferences os boletos, onde retorno é em JSON
      //Se não tiver, retornar uma lista de string vazia
      final response = instace.getStringList("boletos") ?? <String>[];
      //Apos, mapeia para o Model de boleto
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }
}
