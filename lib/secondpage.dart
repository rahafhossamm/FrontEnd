import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'LoginPage.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class secondpage extends StatefulWidget
{
  @override
  secondpagestate createState()=> secondpagestate();
}
class secondpagestate extends State<secondpage>
{
  String stringresponse='';
  Map mapresponse={};
  Map mapBookID={};
  Map mapBorrow={};
  Map mapReturn={};
  Map dataresponse={};
  List listresponse=[];
  var bookID;
  var borrowingID;
  var studentID;
  var message;
  var duedate;

  var penalty;
  var penalty2;
  var length = 0;
  String x='';
  //dynamic y;
  dynamic a0;
  List borrowedList=[];

  Future<void> secondapicall(dynamic studentID) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetlistOfBooks/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({
      "borrowing_id": 0,
      "book_id": 0,
      "student_id": studentID,
      "borrowed_date": "2023-06-06T23:12:53.583Z",
      "due_date": "2023-06-06T23:12:53.583Z",
      "returned_date": "2023-06-06T23:12:53.583Z",
      "penalty": 0
    });

    print('API URL: $apiUrl');
    print('Headers: $headers');
    print('Request Body: $body');

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

// Get the borrowedList key
        borrowedList = decodedData['borrowedList'];
        print(borrowedList);
        length = borrowedList.length;
      }

      var responseData = jsonDecode(response.body);

      mapresponse=json.decode(response.body);
      listresponse = mapresponse['borrowedList'];
      x=listresponse[0].toString();


      print(listresponse[0].toString());

      setState(() {
        length = borrowedList.length;
      });

    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }
  }





  Future<void> GetTheBookID(String isbn) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetTheBookID/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({
      "book_id": 0,
      "title": "string",
      "author": "string",
      "publication_year": 0,
      "isbn": isbn,
      "copies_available": 0
    });

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

        mapBookID=json.decode(response.body);
        bookID=mapBookID['bookID'];
        print(bookID);

        await BorrowAPI(bookID);


      } else {
        print('Failed to fetch student ID. Please try again.');
      }
    } catch (e) {
      print('An error occurred while calling the API. Please try again.');
    }
  }





  Future<void> BorrowAPI(int bookID) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/BorrowingAPI/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({
      "borrowing_id": 0,
      "book_id": bookID,
      "student_id": result,
      "borrowed_date": "2023-06-07T00:16:26.250Z",
      "due_date": "2023-06-07T00:16:26.250Z",
      "returned_date": "2023-06-07T00:16:26.250Z",
      "penalty": 0
    });

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

        mapBorrow=json.decode(response.body);
        message=mapBorrow['message'];
        print(message);

        // await secondapicall(result);
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





  @override void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      secondapicall(result);
    });
  }
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowing Information'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(a0.toString()),Text(a1.toString()),Text(a2.toString()),Text(a3.toString()),Text(a4.toString()),Text(a5.toString()),Text(a6.toString()),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle remove action for Container 1
            },
            icon: Icon(Icons.remove, color: Colors.red),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(b0.toString()),
                  Text(b1.toString()),
                  Text(b2.toString()),
                  Text(b3.toString()),
                  Text(b4.toString()),
                  Text(b5.toString()),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle remove action for Container 2
            },
            icon: Icon(Icons.remove, color: Colors.red),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add action
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}*/

  /*void returnBook(String book) {
  // Perform logic to return the book here
  // Remove the book from the borrowedBooks list
  setState(() {
  borrowedBooks.remove(book);
  });
  }

  void borrowBook() {
  // Perform logic to borrow a book here
  // Show a dialog or navigate to a page to select a book to borrow
  }
 */
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.book,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Book ID: ${borrowedList[index][1]}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      DropdownButton<String>(
                        value: borrowingID,
                        items: <String>[
                          'Borrowing ID: ${borrowedList[index][0]}',
                          'Student ID: ${borrowedList[index][2]}',
                          'Borrowed Date: ${borrowedList[index][3]}',
                          'Due Date: ${borrowedList[index][4]}',
                          'Returned Date: ${borrowedList[index][5]}',
                          'Penalty: ${borrowedList[index][6]}',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Handle dropdown value changes
                        },
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await ReturningAPI(borrowedList[index][1], borrowedList[index][2]);
                },
                icon: Icon(Icons.remove_circle, color: Colors.red),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Handle add action


                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  '#FF0000', // Optional, sets the color of the scan view
                  'Cancel', // Optional, sets the button text for cancellation
                  true, // Optional, sets whether to show the flash icon
                  ScanMode.BARCODE, // Specify the scan mode (BARCODE, QR)
                );

                print(barcodeScanRes);
                await GetTheBookID(barcodeScanRes);
              },



        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }


/*Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      //Text('Borrowing ID: $borrowingID',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold ,fontStyle: FontStyle.italic),),
                      Text('Book ID:$bookID',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                      Text('Student ID: $studentID',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                      Text('Borrowed Date: $borroweddate',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                      Text('Due Date: $duedate',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold ,fontStyle: FontStyle.italic)),
                      Text('Returned Date: $returneddate',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                      Text('Penalty: $penalty',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // Remove block 1 action
                },
                icon: Icon(Icons.remove_circle, color: Colors.red),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text('BO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 16),
                          Text('Borrowing ID: $borrowingID2',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic ),),
                          Text('Book ID:$bookID2',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold ,fontStyle: FontStyle.italic)),
                          Text('Student ID: $studentID',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold ,fontStyle: FontStyle.italic)),
                          Text('Borrowed Date: $borroweddate2',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                          Text('Due Date: $duedate2',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold ,fontStyle: FontStyle.italic)),
                          Text('Returned Date: $returneddate2',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold ,fontStyle: FontStyle.italic)),
                          Text('Penalty: $penalty2',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic )),
                        ])),
              ),
              IconButton(
                onPressed: () {
                  // Remove block 2 action
                },
                icon: Icon(Icons.remove_circle, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add block action
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

*/
  Future<void> ReturningAPI(int BookId, int studentId) async {
    var apiUrl = 'http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/ReturningAPI/';
    var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
    var body = jsonEncode({
      "borrowing_id": 0,
      "book_id": BookId,
      "student_id": studentId,
      "borrowed_date": "2023-06-07T00:16:26.250Z",
      "due_date": "2023-06-07T00:16:26.250Z",
      "returned_date": "2023-06-07T00:16:26.250Z",
      "penalty": 0
    });

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

        mapReturn=json.decode(response.body);
        message=mapReturn['message'];
        print(message);

        // await secondapicall(result);
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
}



