import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signinn.dart';
import 'package:async/async.dart';


// var studentID=23100236;

SigninState ss = SigninState();


class Gettransactions extends StatefulWidget
{
  @override
  Gettransactionsstate createState() => Gettransactionsstate();
}


class Gettransactionsstate extends State<Gettransactions> {
  var studentID= id;
  var length=0;
  List transactionlist=[];
  String stringresponse = '';
  Map mapresponse = {};



  Future<void> Gettransactions(var studentId) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/Gettransactions/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json','Authorization': 'Bearer ${token}'};
    var body = jsonEncode({
      "transaction_id": 0,
      "student_id": studentID,
      "merchant_id": 0,
      "transaction_date": "2023-06-28T05:43:19.888Z",
      "transaction_amount": 0
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
        transactionlist = mapresponse['transactionsRecords'];
        print(transactionlist);
        length = transactionlist.length;
      } else {
        print('Failed to fetch student ID. Please try again.');
      }

      setState(() {
        length = transactionlist.length;
      });
    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }



  }
 @override void initState() {
    Gettransactions(studentID);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Container(
      child: ListView.separated(
        itemCount: length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.monetization_on,
                  size: 32,
                  color: Color(0xFF1f3164),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction ID: ${transactionlist[index][0]}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          'Student ID: ${transactionlist[index][1]}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Merchant ID: ${transactionlist[index][2]}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Transaction Date: ${transactionlist[index][3]}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Transaction Amount: ${transactionlist[index][4]} EGP',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      ),
    );
  }


}