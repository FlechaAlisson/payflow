import 'package:camera/camera.dart';

class BarcodeScannerStatus {
  final isCameraAvailable;
  final error;
  final barcode;
  final bool stopScanner;

  //construtor default
  BarcodeScannerStatus(
      {this.isCameraAvailable = false,
      this.error = '',
      this.barcode = '',
      this.stopScanner = false});

  //factorys são como construtor
  factory BarcodeScannerStatus.available() => BarcodeScannerStatus(
        isCameraAvailable: true,
        stopScanner: false,
      );

  factory BarcodeScannerStatus.error(String message) =>
      BarcodeScannerStatus(error: message, stopScanner: true);

  factory BarcodeScannerStatus.barcode(String barcode) =>
      BarcodeScannerStatus(barcode: barcode, stopScanner: true);

  //so vai exibir a camera se passar nesse teste
  bool get showCamera => isCameraAvailable && error.isEmpty;

  bool get hasError => error.isNotEmpty;

  //so passar o valor de barcode se nao for empty
  bool get hasBarcode => barcode.isNotEmpty;
}
