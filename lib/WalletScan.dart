import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'WalletAdd.dart';
import 'LibraryScan.dart';
import 'dart:convert';
import 'signinn.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

var sid ; //changed from id 

LibraryScanState libraryscanState = LibraryScanState();


class WalletScan extends StatefulWidget
{
  @override
  Walletscanstate createState() => Walletscanstate();
}
class Walletscanstate extends State<WalletScan> {
  String uid = "";
  String SerialNumber='';
  String stringresponse = '';
  Map mapresponse = {};
  var points;


  Future<void> GetUserID(String serialNumber) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
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
        sid=mapresponse['studentID'];
        print(sid);


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
              'assets/images/nfc.gif', // Replace with your image path
              width: 250,
              height: 250,
            ),
            SizedBox(height: 16),
            Container(

              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          const MaterialStatePropertyAll(Color(0xFF1f3164)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                            minimumSize: MaterialStateProperty.all<Size>(Size(200, 50))
                        ),
                      onPressed: () async {
                        NFCTag? tag = await FlutterNfcKit.poll();
                        if (tag != null) {
                          uid = tag.id;
                          print(uid);

                          await GetUserID(uid);
                          if(sid != 0) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalletAdd()),);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        Text('  Card not found'),
                                      ],
                                    ),
                                )
                            );
                          }

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