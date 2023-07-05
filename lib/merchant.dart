import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'WalletAdd.dart';
import 'LibraryScan.dart';
import 'dart:convert';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'Pay.dart';

var id;

LibraryScanState libraryscanState = LibraryScanState();


class merchant extends StatefulWidget
{
  @override
  merchantstate createState() => merchantstate();
}
class merchantstate extends State<merchant> {
  String uid = "";
  String SerialNumber='';
  String stringresponse = '';
  Map mapresponse = {};
  var points;


  Future<void> GetUserID(String serialNumber) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({'serial_no': serialNumber});

    print('API URL: $apiUrl');
    print('Headers: $headers');
    print('Request Body: $body');

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      stringresponse=response.body;
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        mapresponse=json.decode(response.body);
        id=mapresponse['studentID'];
        print(id);


      } else {
        print('Failed to fetch student ID. Please try again.');
      }

    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charge Wallet'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AASTlogo.png', // Replace with your image path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            Container(

              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        NFCTag? tag = await FlutterNfcKit.poll();
                        if (tag != null) {
                          uid = tag.id;
                          print(uid);

                          await GetUserID(uid);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Pay()),);


                          //GetPointsAmount(id);
                        } else {
                          print("No Tag");
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.mobile_friendly,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Scan Here',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}