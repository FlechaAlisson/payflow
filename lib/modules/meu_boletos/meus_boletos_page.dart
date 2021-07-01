import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/themes/apptexts.dart';
import 'package:payflow/shared/widget/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widget/boleto_list_widget/boleto_list_controller.dart';
import 'package:payflow/shared/widget/boleto_list_widget/boleto_list_widget.dart';

class MeusBoletosPages extends StatefulWidget {
  const MeusBoletosPages({Key? key}) : super(key: key);

  @override
  _MeusBoletosPagesState createState() => _MeusBoletosPagesState();
}

class _MeusBoletosPagesState extends State<MeusBoletosPages> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //esse container é só pra delamitar 80
        SingleChildScrollView(
          child: Container(
            height: 80,
            child: Stack(
              children: [
                Container(
                  color: AppColors.primary,
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (_, boletos, __) => AnimatedCard(
                        direction: AnimatedCardDirection.top,
                        child: BoletoInfoWidget(size: boletos.length)),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 16),
          child: Row(
            children: [
              Text(
                "Meus Boletos",
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
    );
  }
}
