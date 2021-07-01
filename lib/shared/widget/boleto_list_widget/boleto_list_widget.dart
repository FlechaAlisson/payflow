import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widget/boleto_list_widget/boleto_list_controller.dart';
import 'package:payflow/shared/widget/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatefulWidget {
  const BoletoListWidget({Key? key, required this.controller})
      : super(key: key);
  final BoletoListController controller;

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: widget.controller.boletosNotifier,
        builder: (_, boletos, __) {
          return Column(
            children: boletos.map((e) => BoletoTileWidget(data: e)).toList(),
          );
        });
  }
}
