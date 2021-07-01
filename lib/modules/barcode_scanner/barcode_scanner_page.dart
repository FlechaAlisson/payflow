import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/themes/apptexts.dart';
import 'package:payflow/shared/widget/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widget/set_label_buttons/set_label_buttons.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto",
            arguments: controller.status.barcode);
      }
      {}
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BottomSheetWidget(
    //   primaryLabel: "Escaner novamente",
    //   secondaryLabel: "Digitar código",
    //   primaryOnPressed: () {},
    //   secondaryOnPressed: () {},
    //   title: "Não foi possível identificar um código de barras.",
    //   subTitle: "Tente novamente ou digite o código do seu boleto",
    // );
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(
                    "Escaneie o código de barras do boleto",
                    style: TextStyles.buttonBackground,
                  ),
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  secondaryLabel: "Adicionar da galeria",
                  primaryOnPressed: () {},
                  secondaryOnPressed: () {},
                )),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return Container(
                  child: BottomSheetWidget(
                    primaryLabel: "Escaner novamente",
                    secondaryLabel: "Digitar código",
                    primaryOnPressed: () {
                      controller.scanWithCamera();
                    },
                    secondaryOnPressed: () {},
                    title: "Não foi possível identificar um código de barras.",
                    subTitle:
                        "Tente novamente ou digite o código do seu boleto",
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
