import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel model = BoletoModel();
  // se for null, é pq tá ok
  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChange({
    String? name,
    String? dueData,
    double? value,
    String? barcode,
  }) {
    //cria uma cópia nova só com os dados novos
    model = model.copyWith(
      name: name,
      dueData: dueData,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoleto() async {
    final instance = await SharedPreferences.getInstance();
    //pega todos os boletos que existem salvos
    final boletos = instance.getStringList("boletos") ?? <String>[];
    //adiciona o que foi criado
    boletos.add(model.toJson());
    //salva tudo de novo
    await instance.setStringList("boletos", boletos);
    return;
  }

  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return saveBoleto();
    }
  }
}
