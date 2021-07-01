import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/themes/apptexts.dart';
import 'package:payflow/shared/widget/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widget/boleto_list_widget/boleto_list_controller.dart';
import 'package:payflow/shared/widget/boleto_list_widget/boleto_list_widget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //esse container é só pra delamitar 80

          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16),
            child: Row(
              children: [
                Text(
                  "Meus Extratos",
                  style: TextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke,
            ),
          ),
          BoletoListWidget(
            controller: controller,
          )
        ],
      ),
    );
  }
}
