import 'package:flutter/material.dart';
//import 'secondpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/post.dart';

class LoginPage extends StatefulWidget
{
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {

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
  String studentID='';
  var  userID;
  String SerialNumber='';
  Student? student;
  //Map mapresponse = {};
  //Map dataresponse = {};
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

        if (data != null && data['serial_no'] != null) {
           studentID = data['serial_no'];
           student = Student.fromJson(data);
           print('Student ID: ${student!.studentID}');
           print('Student ID: $studentID');
        } else {
          print('Failed to retrieve student ID. Please check the response format.');
        }
      } else {
        print('Failed to fetch student ID. Please try again.');
      }
    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }
  }

  //void main() {
    // Replace VALUE with the desired serial number
    //var serialNumber = '11110020';

    //print('Calling API with Serial Number: $serialNumber');
    //apicall(serialNumber);
  //}


  @override
  void initState() {
    apicall('11110000');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),),
        body: Center(child:Text(studentID.toString()),));
  }
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
}
