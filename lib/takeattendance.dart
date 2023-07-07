import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:llibrary/LibraryScan.dart';
import 'signinn.dart';

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({Key? key}) : super(key: key);

  @override
  _TakeAttendanceState createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  final _storage = const FlutterSecureStorage();
  bool isLoading = true;
  String regno = "";
  String? accountid;
  String? coursecode;
  String? coursename;
  String? slot;
  String? day;
  String uid = "";
  bool error = false;
  String msg = "Opps something wrong happened";
  Future<String?> acc() async {
    accountid = await _storage.read(key: "user_id");
    print("accountid:$accountid");
    return accountid;
  }

  Future<String?> cn() async {
    coursename = await _storage.read(key: "course_name");
    print("coursename:$coursename");
    return coursename;
  }

  Future<String?> cc() async {
    coursecode = await _storage.read(key: "course_code");
    print("coursecode:$coursecode");
    return coursecode;
  }

  Future<String?> cd() async {
    day = await _storage.read(key: "day");
    print("coursecode:$day");
    return day;
  }

  Future<String?> cs() async {
    slot = await _storage.read(key: "slot");
    print("slot:$slot");
    return slot;
  }

  String Classno = "";
  String Exists = "";
  String serialno=""; //TODO: To be replaced by your NFC Implementation
  Future<void> useridusingserial() async {

    serialno=uid;
    http.Response response = await GetUserID(serialno);
    print("Status Code  ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        regno = map['studentID'].toString();
        print("Received Class numbesssr $Classno");
        // print(json.decode(response.body));
        isLoading = false;
        error = false;
        takeattendancemanually();
      });
    } else if (response.statusCode == 400 ||
        response.statusCode == 404 ||
        response.statusCode == 401) {
      setState(() {
        isLoading = false;
        error = true;
      });
    }
  }

  Future<void> takeattendancemanually() async {
    if (regno != "") {
      setState(() {
        isLoading = true;
      });
      http.Response response = await Checktakes(regno!, coursecode!, Classno!);
      print("Status Code  ${response.statusCode}");

      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> map = json.decode(response.body);
          Exists = map['message'];
          print("Received  $Exists");
          if (Exists == "Exists") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  Text('  Attendance took successfully'),
                ],
              )),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  Text('  Student is not registered in this class'),
                ],
              )),
            );
          }
          // print(json.decode(response.body));
          isLoading = false;
          error = false;
          regno = "";
        });
      } else if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 401) {
        setState(() {
          isLoading = false;
          error = true;
        });
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //       content: Text('Invalid Credentials')),
      // );

    }
  }

  Future<void> runcmd() async {
    String? userid = await acc();
    String? coursecode = await cc();
    String? z = await cn();
    String? day = await cd();
    String? slot = await cs();
    http.Response response =
        await GetScheduleID(userid!, coursecode!, day!, slot!);
    print("Status Code  ${response.statusCode}");

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        Classno = map['classNumber'];
        print("Received Class numbesssr $Classno");
        // print(json.decode(response.body));
        isLoading = false;
        error = false;
      });
    } else if (response.statusCode == 400 ||
        response.statusCode == 404 ||
        response.statusCode == 401) {
      setState(() {
        isLoading = false;
        error = true;
      });
    }
  }

  void initState() {
    runcmd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: BackButton(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${now.day} ${DateFormat.MMMM().format(now)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFabaeae),
                                ),
                              ),
                              const Text(
                                "Hello,",
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 25.0,
                                  wordSpacing: 1,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            // child: Icon(Icons.person),
                            child: Image.asset(
                              "assets/images/pp.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(
                          radius: 20,
                          color: Colors.black,
                        ),
                      )
                    : (error)
                        ? Center(
                            child: Text(
                              msg,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 28.0,
                                    bottom: 8),
                                child: Text(
                                  "$coursename attendance",
                                  style: TextStyle(
                                    // color: Colors.black,
                                    fontSize: 23.0,
                                    wordSpacing: 1,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    useridusingserial();
                                  },
                                  child: GestureDetector(
                                    onTap: () async {
                                      // Action to perform when the image is tapped
                                      NFCTag? tag = await FlutterNfcKit.poll();
                                      if (tag != null) {
                                        uid = tag.id;
                                        print(uid);
                                      } else {
                                        print("No Tag");
                                      }
                                      useridusingserial();
                                      // You can perform any desired action here
                                    },
                                    child: Image.asset('assets/images/nfc.gif',
                                      width:
                                      MediaQuery.of(context).size.width * 0.7,), // Replace with your image path
                                  ),

                                  // Image.asset(
                                  //   "assets/images/nfc.gif",

                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (val) {
                                    setState(() {
                                      regno = val;
                                    });
                                  },
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Registration Number",
                                    // labelText: label,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        // color: Colors.grey.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    // backgroundColor: (c.enabled)
                                    //     ? const MaterialStatePropertyAll(Colors.blue)
                                    //     : MaterialStatePropertyAll(Colors.blue.shade300),
                                  ),
                                  onPressed: () async {
                                    takeattendancemanually();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                      child: isLoading
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text(
                                              'Take Attendance Manually',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<http.Response> GetScheduleID(
    String id, String coursecode, String day, String slot) {
  return http.post(
    Uri.parse(
        "http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetScheduleID/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer ${token}'
    },
    body: jsonEncode(<String, String>{
      "schedule_id": "0",
      "course_code": coursecode,
      "instructor_id": id,
      "day": day,
      "slots": slot,
      "class_no": ""
    }),
  );
}

Future<http.Response> Checktakes(
    String regno, String coursecode, String classno) {
  return http.post(
    Uri.parse(
        "http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/CheckTakes/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer ${token}'
    },
    body: jsonEncode(<String, String>{
      "student_id": regno,
      "course_code": coursecode,
      "class_no": classno
    }),
  );
}

Future<http.Response> GetUserID(String serialno) {
  return http.post(
    Uri.parse(
        "http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetUserID/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer ${token}'
    },
    body: jsonEncode(<String, String>{
      "serial_no": serialno,
    }),
  );
}
