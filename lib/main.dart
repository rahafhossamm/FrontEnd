
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:llibrary/Borrow.dart';
import 'package:llibrary/LibraryPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tensor-2.gif',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            Text(
              'Scan Here',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                NFCTag? tag = await FlutterNfcKit.poll();
                if (tag != null) {
                  String uid = tag.id;
                  print(uid);
                } else {
                  print("No Tag");
                }
              },
              child: Text('Read NFC Tag'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  '#FF0000', // Optional, sets the color of the scan view
                  'Cancel', // Optional, sets the button text for cancellation
                  true, // Optional, sets whether to show the flash icon
                  ScanMode.BARCODE, // Specify the scan mode (BARCODE, QR)
                );

                print(barcodeScanRes);
              },
              child: Text('Scan Here')
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:llibrary/Borrow.dart';
import 'LibraryPage.dart';

void main() async{
  NFCTag tag = await FlutterNfcKit.poll();
  if(tag != null){
    String uid = tag.id;
    print(uid);
  }
  else {
    print("No Tag");
  }
  runApp(MyApp());
}
*/
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//       ),
//       home: LibraryPage(),
//     );
//   }
// }
/*class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'Please Choose the course:',
      'answers': ['Big Data', 'Cyber Security', 'Database'],
    },
    {
      'questionText': 'Please choose  the slot:',
      'answers': ['Saturday - 8:30', 'Saturday - 10:30', 'Sunday - 10:30'],
    },
  ];
  var _questionIndex = 0;
  bool _supportsNFC = false;
  bool _reading = false;
  // StreamSubscription<NDEFMessage> _stream;

  void _answerQuestion() {
    print('isNfcAvailable');
    setState(() {
      _questionIndex++;
    });
    print(_questionIndex);

    if (_questionIndex < _questions.length) {
      print('We have more questions');
    }
  }

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Text('HI AYHAGAA');


  }
}
*/
