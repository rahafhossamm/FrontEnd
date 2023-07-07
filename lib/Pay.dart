import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signinn.dart';
import 'merchant.dart';

// merchantstate merchant1 = merchantstate();
//id changed to sid from merchant.dart
class Pay extends StatefulWidget {
  @override
  Paystate createState() => Paystate();
}

class Paystate extends State<Pay> {
  String enteredText = '';
  String stringresponse = '';
  String stringresponse2 = '';
  Map mapresponse = {};
  Map mapresponse2 = {};
  Map dataresponse = {};
  var points;
  int merchantid=int.parse(id);

  Future<void> refreshWidget() async {
    await Paymentprocess(sid);
    setState(() {});
  }



  Future<void> Paymentprocess(int amount) async {
    var apiUrl =
        'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/Paymentprocess/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
    var body = jsonEncode({
      "transaction_id": 0,
      "student_id": sid,
      "merchant_id": merchantid,
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

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POS'),
      ),
      body: AlertDialog(
        title: Text('Pay Amount'),
        content: TextField(
          keyboardType: TextInputType.number,
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Enter the amount...',
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Pay'),
            onPressed: () async {
              // Perform payment logic here
              String inputText = _textEditingController.text;
              await Paymentprocess(int.parse(inputText));
              // Display a toast or perform further actions with the input text
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => merchant()),);
            },
          ),
          ElevatedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => merchant()),); // Close the dialogue
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), // Set the background color of the button
            ),
          ),
        ],
      ),
    );
  }
}
