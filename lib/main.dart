import 'package:flutter/material.dart';
import 'LoginPage.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Login Page',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: LoginPage(),
  );
}
}
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Book {
  final int id;
  final String title;
  final String author;

  Book({
    required this.id,
    required this.title,
    required this.author,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
    );
  }
}

class ApiService {
  Future<String> getUserId(String serialNumber) async {
    var apiUrl = 'http://smartcampus-env-1.eba-3jdwppkg.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'serial_no': serialNumber});

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['student_id'];
      } else {
        throw Exception('Failed to fetch student ID');
      }
    } catch (e) {
      throw Exception('An error occurred while calling the API');
    }
  }

  Future<List<Book>> getBookList(String studentId) async {
    var apiUrl = 'http://smartcampus-env-1.eba-3jdwppkg.eu-west-3.elasticbeanstalk.com/api/GetlistBooks/';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'borrowing_id': 0,
      'book_id': 0,
      'student_id': studentId,
      'borrowed_date': '2023-06-06T23:12:53.583Z',
      'due_date': '2023-06-06T23:12:53.583Z',
      'returned_date': '2023-06-06T23:12:53.583Z',
      'penalty': 0
    });

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<Book> books = [];

        for (var bookData in data) {
          books.add(Book.fromJson(bookData));
        }

        return books;
      } else {
        throw Exception('Failed to fetch book list');
      }
    } catch (e) {
      throw Exception('An error occurred while calling the API');
    }
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController serialNumberController = TextEditingController();
  String specificSerialNumber = 'YOUR_SPECIFIC_SERIAL_NUMBER'; // Replace with your specific serial number
  ApiService apiService = ApiService();

  void login() async {
    // Call the API with the entered serial number
    var studentId = await apiService.getUserId(specificSerialNumber);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookListPage(studentID: studentId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AASTlogo.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            TextField(
              controller: serialNumberController,
              decoration: InputDecoration(
                labelText: 'Serial Number',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListPage extends StatefulWidget {
  final String studentID;

  BookListPage({required this.studentID});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  ApiService apiService = ApiService();
  List<Book> borrowedBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBookList();
  }

  void fetchBookList() async {
    try {
      var bookList = await apiService.getBookList(widget.studentID);
      setState(() {
        borrowedBooks = bookList;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while fetching the book list. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void returnBook(String book) {
    borrowedBooks.remove(book);
    setState(() {});
  }

  void borrowBook() {
    // Perform logic to borrow a book here
    // Show a dialog or navigate to a page to select a book to borrow
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: ListView.builder(
        itemCount: borrowedBooks.length,
        itemBuilder: (context, index) {
          final book = borrowedBooks[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            trailing: IconButton(
              onPressed: () => returnBook(book),
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: borrowBook,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
*/
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController serialNumberController = TextEditingController();
  String specificSerialNumber = "11110000"; // Specific serial number value
  String studentID = '';

  void login() {
    // Call the API with the specific serial number
    callAPI(specificSerialNumber);
  }

  Future<void> callAPI(String serialNumber) async {
    var apiUrl = 'http://smartcampus-env-1.eba-3jdwppkg.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'serial_no': serialNumber});

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        studentID = data['student_id'];

        // Call the second API with the student ID
        callSecondAPI();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('API Error'),
            content: Text('Failed to fetch student ID. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> callSecondAPI() async {
    var apiUrl = 'http://smartcampus-env-1.eba-3jdwppkg.eu-west-3.elasticbeanstalk.com/api/GetlistBooks/';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'borrowing_id': 0,
      'book_id': 0,
      'student_id': studentID,
      'borrowed_date': '2023-06-06T23:12:53.583Z',
      'due_date': '2023-06-06T23:12:53.583Z',
      'returned_date': '2023-06-06T23:12:53.583Z',
      'penalty': 0
    });

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        // Process the response of the second API call here
        // ...
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('API Error'),
            content: Text('Failed to call the second API. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while calling the second API. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AASTlogo.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            TextField(
              controller: serialNumberController,
              decoration: InputDecoration(
                labelText: 'Serial Number',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                specificSerialNumber = serialNumberController.text;
                login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController serialNumberController = TextEditingController();
 String specificSerialNumber = "11110000";
  void login() {
    // Call the API with the entered serial number
    callAPI(specificSerialNumber);

  }

  Future<void> callAPI(String serialNumber) async {
    var apiUrl = 'http://smartcampus-env-1.eba-3jdwppkg.eu-west-3.elasticbeanstalk.com/api/GetUserID/';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'serial_no': serialNumber});

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var studentID = data['student_id'];

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookListPage(studentID: studentID)),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('API Error'),
            content: Text('Failed to fetch student ID. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while calling the API. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AASTlogo.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            TextField(
              controller: serialNumberController,
              decoration: InputDecoration(
                labelText: 'Serial Number',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListPage extends StatefulWidget {
  final String studentID;

  BookListPage({required this.studentID});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final List<String> borrowedBooks = [
    'Book 1',
    'Book 2',
    'Book 3',
  ];

  void returnBook(String book) {
    borrowedBooks.remove(book);
    setState(() {});
  }

  void borrowBook() {
    // Perform logic to borrow a book here
    // Show a dialog or navigate to a page to select a book to borrow
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: ListView.builder(
        itemCount: borrowedBooks.length,
        itemBuilder: (context, index) {
          final book = borrowedBooks[index];
          return ListTile(
            title: Text(book),
            trailing: IconButton(
              onPressed: () => returnBook(book),
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: borrowBook,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    // Perform authentication logic here (e.g., check against a database)
    // Assume a simple hardcoded check for demonstration purposes
    if (usernameController.text == 'admin' && passwordController.text == 'password') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookListPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/library_logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final List<String> borrowedBooks = [
    'Book 1',
    'Book 2',
    'Book 3',
  ];

  void returnBook(String book) {
    // Perform logic to return the book here
    // Remove the book from the borrowedBooks list
    setState(() {
      borrowedBooks.remove(book);
    });
  }

  Future<void> borrowBook() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000', // Optional, sets the color of the scan view
      'Cancel', // Optional, sets the button text for cancellation
      true, // Optional, sets whether to show the flash icon
      ScanMode.BARCODE, // Specify the scan mode (BARCODE, QR)
    );

    // Check if the barcode scanning was successful
    if (barcodeScanRes != '-1') {
      String scannedBook = 'Book $barcodeScanRes';

      setState(() {
        borrowedBooks.add(scannedBook);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: ListView.builder(
        itemCount: borrowedBooks.length,
        itemBuilder: (context, index) {
          final book = borrowedBooks[index];
          return ListTile(
            title: Text(book),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => returnBook(book),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: borrowBook,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    // Perform authentication logic here (e.g., check against a database)
    // Assume a simple hardcoded check for demonstration purposes
    if (usernameController.text == 'admin' && passwordController.text == 'password') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookListPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AASTlogo.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final List<String> borrowedBooks = [
    'Book 1',
    'Book 2',
    'Book 3',
  ];

  void returnBook(String book) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: ListView.builder(
        itemCount: borrowedBooks.length,
        itemBuilder: (context, index) {
          final book = borrowedBooks[index];
          return ListTile(
            title: Text(book),
            trailing: IconButton(
              onPressed: () => returnBook(book),
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: borrowBook,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
*/
