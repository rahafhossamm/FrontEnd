import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LoginPage.dart';
import 'dart:convert';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

LoginPageState loginPageState = LoginPageState();

class Payment extends StatefulWidget
{
  @override
  Paymentstate createState() => Paymentstate();
}
class Paymentstate extends State<Payment> {
  String uid = "";
  String SerialNumber='';
  String stringresponse = '';
  Map mapresponse = {};
  var points;

  Future<void> GetPointsAmount(String studentId) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetPointsAmount/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({
      "student_id": studentId,
      "points_balance": 0
    }
    );

    print('API URL: $apiUrl');
    print('Headers: $headers');
    print('Request Body: $body');

    try {
      var response = await http.post(
          Uri.parse(apiUrl), headers: headers, body: body);
      stringresponse = response.body;
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        mapresponse = json.decode(response.body);
        points = mapresponse['points'];
        print(points);
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
                          loginPageState.apicall(uid); //GetUserID API
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