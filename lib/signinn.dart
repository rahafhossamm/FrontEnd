import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:llibrary/LibraryScan.dart';
import 'package:llibrary/WalletScan.dart';
import 'package:llibrary/gettransactions.dart';
import 'package:llibrary/merchant.dart';
// import 'doc_courses.dart';
import 'doctorcourses.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String id = "";


class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<Signin> {
  @override
  final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  bool x = true;
  bool isLoading = false;

  String password = "";
  final snackBar = const SnackBar(
    content: Text('Invalid Username/Password'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Wrap(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/AASTlogo.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onChanged: (val) {
                              setState(() {
                                id = val;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Registration Number",
                              // labelText: label,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              icon: const Icon(
                                Icons.numbers,
                                color: Colors.grey,
                              ),
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
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            obscureText: x,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Password",

                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    x = !x;
                                  });
                                },
                                icon: Icon(
                                  (x) ? Icons.visibility_off : Icons.visibility,
                                ),
                              ),
                              // labelText: label,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              icon: const Icon(
                                Icons.lock_outlined,
                                color: Colors.grey,
                              ),
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
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      const MaterialStatePropertyAll(Color(0xFF1f3164)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      // backgroundColor: (c.enabled)
                      //     ? const MaterialStatePropertyAll(Colors.blue)
                      //     : MaterialStatePropertyAll(Colors.blue.shade300),
                    ),
                    // onPressed: c.enabled ? c.signIn : null,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        http.Response response =
                        await authentication(id, password);
                        print("Status Code  " + response.statusCode.toString());
                        if (response.statusCode == 200) {
                          Map<String, dynamic> map = json.decode(response.body);
                          var accountType = map['user_type'];
                          var id = map["user_id"];
                          print("Recieved accountType  " + accountType);
                          print(json.decode(response.body));
                          if (accountType != "Not Authorized") {
                            await _storage.write(
                                key: "user_type", value: accountType);
                            await _storage.write(
                                key: "user_id", value: id.toString());
                            if (accountType == "instructor") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorsCoursess(),
                                ),
                              );
                            } else if (accountType == "staff") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LibraryScan(),
                                ),
                              );
                            } else if (accountType == "cashier") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WalletScan(),
                                ),
                              );
                            }else if (accountType == "merchant") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => merchant(),
                                ),
                              );
                            } else if (accountType == "student") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Gettransactions(),
                                ),
                              );
                            }
                          } else if (response.statusCode == 200 &&
                              accountType == "Not Authorized") {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else if (response.statusCode == 400) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid Credentials')),
                          );
                          print("Invalid Credentials");
                        } else if (response.statusCode == 408) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Request Timeout')),
                          );

                          print("Request Timeout");
                        } else if (response.statusCode == 500) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Internal Server Error')),
                          );

                          print("Internal Server Error");
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Generic Error')),
                          );
                          print("Generic Error");
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Center(
                        child: isLoading
                            ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          'Sign in',
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
          ),
        ),
      ),
    );
  }
}

Future<http.Response> authentication(String id, String password) {
  return http.post(
    Uri.parse(
        "http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/Login/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"user_id": id, "password": "$password"}),
  );
}