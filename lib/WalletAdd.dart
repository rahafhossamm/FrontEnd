import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signinn.dart';
import 'WalletScan.dart';
//changed id imported from walletscan to sid

Walletscanstate walletScan = Walletscanstate();

class WalletAdd extends StatefulWidget {
  @override
  WalletAddState createState() => WalletAddState();
}

class WalletAddState extends State<WalletAdd> {
  String enteredText = '';
  String stringresponse = '';
  String stringresponse2 = '';
  Map mapresponse = {};
  Map mapresponse2 = {};
  Map dataresponse = {};
  var points;
  int merchantid=int.parse(id); //to be changed 

  Future<void> getPointsAmount(int studentId) async {
    var apiUrl =
        'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetPointsAmount/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
    var body = jsonEncode({
      "student_id": studentId,
      "points_balance": 0,
    });

    print('API URL: $apiUrl');
    print('Headers: $headers');
    print('Request Body: $body');

    try {
      var response =
      await http.post(Uri.parse(apiUrl), headers: headers, body: body);
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

  Future<void> refreshWidget() async {
    await getPointsAmount(sid);
    setState(() {});
  }



  Future<void> ChargeProcess(int amount) async {
    var apiUrl =
        'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/Chargeprocess/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
    var body = jsonEncode({
      "transaction_id": 0,
      "student_id": sid,
      "merchant_id": 0,
      "transaction_date": "2023-06-28T05:44:50.771Z",
      "transaction_amount": amount
    }
    );

    print('API URL: $apiUrl');
    print('Headers: $headers');
    print('Request Body: $body');

    try {
      var response =
      await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      stringresponse2 = response.body;
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        mapresponse2 = json.decode(response.body);
        points = mapresponse2['points'];
        print(points);
      } else {
        print('Failed to fetch student ID. Please try again.');
      }
    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }
  }


  void _showAddTextDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Amount'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                enteredText = value;
              });
            },
            decoration: InputDecoration(hintText: 'Enter charging amount'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Add'),
              onPressed: () async {
                Navigator.of(context).pop();
                // Do something with the entered text, such as storing it in a variable or performing an action
                // Here, we're just printing the entered text
                print('Entered Text: $enteredText');
                await ChargeProcess(int.parse(enteredText));
                refreshWidget();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    print(sid);
    getPointsAmount(sid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronic Wallet'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WalletScan()),);
          },
        ),
      ),
      body: FutureBuilder<void>(
        future: getPointsAmount(sid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              points == null) {
            // Show a loading indicator or any other placeholder
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle error state
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Value is not null, display it
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 120,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Amount: $points',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTextDialog,
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
