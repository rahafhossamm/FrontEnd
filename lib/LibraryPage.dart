
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LibraryPage extends StatefulWidget {
  @override
  LibraryPageState createState() => LibraryPageState();
}

class LibraryPageState extends State<LibraryPage> {
  String _nfcData = '';
  String _barcodeData = '';
  bool _scanningBarcode = false;

  @override
  void initState() {
    super.initState();
    _initNFC();
  }

  Future<void> _initNFC() async {
    // NFC.isNDEFSupported.then((bool isSupported) {
    //   if (isSupported) {
    //     _readNFC();
    //   }
    // });
  }

  Future<void> _readNFC() async {
    // NFC.readNDEF().listen((NDEFMessage message) {
    //   setState(() {
    //     _nfcData = message.payload;
    //   });
    // });
  }

  Future<void> _scanBarcode() async {
    setState(() {
      _scanningBarcode = true;
    });

    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Color for the scan button
        'Cancel', // Text for the cancel button
        true, // Show flash icon
        ScanMode.BARCODE, // Scan mode: BARCODE or QR
      );

      if (result != '-1') {
        setState(() {
          _barcodeData = result;
        });
      }
    } catch (e) {
      // Handle error, if any
      print(e.toString());
    }

    setState(() {
      _scanningBarcode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Library App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('NFC Data: $_nfcData'),
              if (_scanningBarcode)
                CircularProgressIndicator()
              else
                Text('Barcode Data: $_barcodeData'),
              ElevatedButton(
                onPressed: _scanBarcode,
                child: Text('Scan Barcode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
