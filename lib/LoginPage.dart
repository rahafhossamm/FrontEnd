import 'package:flutter/material.dart';
// import 'package:llibrary3/secondtry.dart';
import 'secondpage.dart';
// import 'secondtry.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import 'package:llibrary/secondpage.dart';

var result;
//import 'model/post.dart';
secondpagestate secondPageState = secondpagestate();


class LoginPage extends StatefulWidget
{
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  String uid = "";
//final TextEditingController studentserial= TextEditingController();

//void login()
//{
//String enteredserial=studentserial.text;
//if(enteredserial=='11110000') {
  //Navigator.pushReplacement(
  // context,
  //MaterialPageRoute(builder: (context) => secondpage()));
  //}
  //else
  //{
  //print('This student can not be fetched');
  //}
  //}
  String stringresponse = '';
  dynamic studentID;
  var  userID;
  String SerialNumber='';
  //Student? student;
  Map mapresponse = {};
  Map dataresponse = {};

  //List listresponse = [];

  //@override
  //initstate() {
    //super.initState();
    //apicall(SerialNumber);
  //}

/*Future apicall() async{
  http.Response response;
  response= await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
  //print(response);
  if(response.statusCode==200)
    {
      //print(response.body);
      //return null;
      setState(() {
        mapresponse=json.decode(response.body);
        //print(stringresponse.toString());
        print(mapresponse.toString());
        //dataresponse=mapresponse['data'];
        listresponse=mapresponse['data'];

      });
    }
  else{
    throw Exception('can not load');
  }
}
*/
  //Future<void> apicall(String serialNumber) async {
    //http.Response response;
    //var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    //var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    //var body = jsonEncode({'serial_no': serialNumber});
    //response = await http.post(Uri.parse(
        //"http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetUserID/"),
        //headers: headers, body: body);
    //if (response.statusCode == 200) {
      //setState(() {
        //mapresponse = json.decode(response.body);
        //dataresponse = mapresponse['studentID'];
        //print(dataresponse.toString());
        //listresponse=mapresponse['studentID'];
      //});
    //}
    //else {
      //throw Exception('can not load');
    //}
  //}




  Future<void> apicall(String serialNumber) async {
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

        //print(mapresponse['studentID']);

        // print(data);
        // if (data != null && data['serial_no'] != null) {
        //    //studentID = data['serial_no'];
        //    studentID = data['studentID'].toString();
        //    //student = Student.fromJson(data);
        //    //print('Student ID: ${student!.studentID}');
        //    //print('Student ID: $studentID');
        // } else {
        //   print('Failed to retrieve student ID. Please check the response format.');
        // }
      } else {
        print('Failed to fetch student ID. Please try again.');
      }
    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }
  }



  //Future<void> secondapicall(dynamic studentID) async {
    //var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetlistOfBooks/';
    //var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    //var body = jsonEncode({
      //"borrowing_id": 0,
      //"book_id": 0,
      //"student_id": studentID,
      //"borrowed_date": "2023-06-06T23:12:53.583Z",
      //"due_date": "2023-06-06T23:12:53.583Z",
      //"returned_date": "2023-06-06T23:12:53.583Z",
      //"penalty": 0
    //});

    //print('API URL: $apiUrl');
    //print('Headers: $headers');
    //print('Request Body: $body');

    //try {
      //var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      //print('Response Status Code: ${response.statusCode}');
      //print('Response Body: ${response.body}');

      //if (response.statusCode == 200) {
        //var responseData = jsonDecode(response.body);

        // Assuming the response contains a list of borrowed books
        //if (responseData != null && responseData['books'] != null) {
          //var books = responseData['books'];

          // Process each borrowed book
          //for (var book in books) {
            //var bookId = book['book_id'];
            //var bookTitle = book['title'];
            //var bookAuthor = book['author'];

            // Do something with the borrowed book information
            //print('Borrowed Book ID: $bookId');
            //print('Title: $bookTitle');
            //print('Author: $bookAuthor');
            //print('---');
          //}
        //} else {
          //print('Failed to retrieve borrowed book data. Please check the response format.');
        //}
      //} else {
        //print('Second API call failed with status code ${response.statusCode}');
      //}
    //} catch (e) {
      //print('An error occurred while calling the API. Please try again.');
    //}
  //}

  //void main() {
    // Replace VALUE with the desired serial number
    //var serialNumber = '11110020';

    //print('Calling API with Serial Number: $serialNumber');
    //apicall(serialNumber);
  //}


  // @override
  // void initState() {
  //   apicall(uid);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),),
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
        //body: Center(child: studentID != null ? Text(studentID) : CircularProgressIndicator(),));

//body: Center(child: Text(listresponse[5].toString()),));
//body: ListView.builder(itemBuilder: (context,index){ return Container(child: Column(children: [
//Padding(
//padding: const EdgeInsets.all(8.0),
//child: Image.network(listresponse[index]['avatar']),
//),Text(listresponse[index]['first_name'.toString()])],),);},itemCount: listresponse==null? 0: listresponse.length,));}}
//),body:Center(child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
//Image.asset('assets/images/AASTlogo.jpg',width: 150,height: 150,),
//SizedBox(height: 16,),
//TextField(controller: studentserial,decoration: InputDecoration(labelText: 'SerialNumber'),),
//SizedBox(height: 16,),
//ElevatedButton(onPressed:login ,child:Text(stringresponse.toString()),),
//],),),
//);

