import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/themes/apptexts.dart';
import 'package:payflow/shared/widget/input_text/input_text_widget.dart';
import 'package:payflow/shared/widget/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();
  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barCodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barCodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.input,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
              child: Text(
                'Preencha os dados do boleto',
                style: TextStyles.titleBoldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      validator: controller.validateName,
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                    ),
                    InputTextWidget(
                      validator: controller.validateVencimento,
                      isNumber: true,
                      label: "Vencimento",
                      controller: dueDateInputTextController,
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChange(dueData: value);
                      },
                    ),
                    InputTextWidget(
                      //o validator recebe um double e o value tá como string
                      //dessa forma, pega o valor que tá no moneyInputController
                      validator: (_) => controller
                          .validateValor(moneyInputTextController.numberValue),
                      isNumber: true,
                      label: "Valor",
                      controller: moneyInputTextController,
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        controller.onChange(
                            value: moneyInputTextController.numberValue);
                      },
                    ),
                    InputTextWidget(
                      validator: controller.validateCodigo,
                      initialValue: widget.barcode,
                      controller: barCodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        primaryLabel: "Cancelar",
        primaryOnPressed: () {},
        secondaryLabel: "Cadastrar",
        secondaryOnPressed: () async {
          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
      ),
    );
  }
}
