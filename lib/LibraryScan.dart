import 'dart:async';
import 'package:flutter/material.dart';
import 'secondpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'signinn.dart';


var result;
// var token;
secondpagestate secondPageState = secondpagestate();


class LibraryScan extends StatefulWidget
{
  @override
  LibraryScanState createState() => LibraryScanState();
}
class LibraryScanState extends State<LibraryScan> {
  String uid = "";
  String stringresponse = '';
  dynamic studentID;
  var  userID;
  String SerialNumber='';
  Map mapresponse = {};
  Map dataresponse = {};


  Future<void> apicall(String serialNumber) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
    // var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
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
         // studentID = data['studentID'].toString();

        //  print(studentID);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => secondpage()),);
        mapresponse=json.decode(response.body);
        result=mapresponse['studentID'];
        print(result);

        // secondPageState.secondapicall(result);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => secondpage()),);


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
          title: Text('Student Scan'),),
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
                    apicall(uid);
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
