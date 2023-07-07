import 'dart:math';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'coursedetails.dart';
import 'signinn.dart';
class DoctorsCoursess extends StatefulWidget {
  DoctorsCoursess({Key? key}) : super(key: key);

  @override
  _DoctorsCoursessState createState() => _DoctorsCoursessState();
}

class _DoctorsCoursessState extends State<DoctorsCoursess> {
  @override
  String? accountid;

  final _storage = const FlutterSecureStorage();
  bool isLoading = true;
  bool error = false;
  String msg = "Opps something wrong happened";
  Future<String?> acc() async {
    accountid = await _storage.read(key: "user_id");
    print("accountid:$accountid");
    return accountid;
  }

  List<Color> colorslist = [
    const Color(0xffb554e8),
    const Color(0xff75e1bc),
    const Color(0xffefaa58),
    const Color(0xff76bfcd),
    const Color(0xffa8d7f4),
    const Color(0xfff1a9a3),
    const Color(0xff56a0f2),
    const Color(0xfff28d66),
    const Color(0xff5e6778),
    const Color(0xff81c8a4),
    const Color(0xff75c5c2),
  ];
  int numberofcourses = 0;
  late final List<dynamic> successList;
  Future<void> runcmd() async {
    String? x = await acc();
    print("test $x");
    http.Response response = await GetCourses(x!);
    print("Status Code  " + response.statusCode.toString());

    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> map = json.decode(response.body);
        numberofcourses = map['numberOfCourses'];
        successList = map['courses'];
        print(successList[0][1]);
        print("Recieved number of courses $numberofcourses");
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            now.day.toString() +
                                " " +
                                DateFormat.MMMM().format(now),
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
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Divider(
              //     thickness: 2,
              //   ),
              // ),
              ImageSlideshow(
                indicatorColor: Colors.blue,
                onPageChanged: (value) {
                  // debugPrint('Page changed: $value');
                },
                autoPlayInterval: 6000,
                isLoop: true,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/aast1.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/aast2.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      'assets/images/aast3.jpeg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 28.0, bottom: 8),
                child: Text(
                  "Your Courses",
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
              Expanded(
                child: isLoading
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
                        : GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            children: [
                              for (int i = 0; i < numberofcourses; i++)

                                // Text(i.toString()),
                                SizedBox(
                                  width: double.infinity,
                                  // width: min(MediaQuery.of(context).size.width * .50, 250) -
                                  //     18,
                                  height: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await _storage.write(
                                            key: "course_code",
                                            value: successList[i][0]);
                                        await _storage.write(
                                            key: "course_name",
                                            value: successList[i][1]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CourseDetails()),
                                        );
                                      },
                                      child: Card(
                                        color: colorslist[Random().nextInt(10)],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        shadowColor: colorslist[0],
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Text(
                                                  successList[i][1],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: ColoredBox(
                                                  color: Colors.grey
                                                      .withOpacity(0.9),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    child: Text(
                                                      successList[i][0],
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                ),
                              // SizedBox(
                              //   width: double.infinity,
                              //   // width: min(MediaQuery.of(context).size.width * .50, 250) -
                              //   //     18,
                              //   height: 250,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(bottom: 8.0),
                              //     child: Card(
                              //       color: Color(0xff75e1bc),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(30.0),
                              //       ),
                              //       shadowColor: Colors.grey,
                              //       child: Stack(
                              //         children: [
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Expanded(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.end,
                              //                   children: [
                              //                     Expanded(
                              //                       child: ClipRRect(
                              //                         borderRadius:
                              //                             const BorderRadius.only(
                              //                                 topLeft:
                              //                                     Radius.circular(30),
                              //                                 topRight:
                              //                                     Radius.circular(30)),
                              //                         child: Image.asset(
                              //                           "assets/images/ai.jpg",
                              //                           width: double.infinity,
                              //                           fit: BoxFit.fill,
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Padding(
                              //                 padding: EdgeInsets.all(18.0),
                              //                 child: Text(
                              //                   "Artificial Intelligence",
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Positioned(
                              //             bottom: 65,
                              //             left: 10,
                              //             child: ClipRRect(
                              //               borderRadius: BorderRadius.circular(30.0),
                              //               child: ColoredBox(
                              //                 color: Colors.grey.withOpacity(0.9),
                              //                 child: const Padding(
                              //                   padding: EdgeInsets.all(6.0),
                              //                   child: Text(
                              //                     "CC526",
                              //                     style: TextStyle(
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: double.infinity,
                              //   // width: min(MediaQuery.of(context).size.width * .50, 250) -
                              //   //     18,
                              //   height: 250,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(bottom: 8.0),
                              //     child: Card(
                              //       color: Color(0xfff1aa56),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(30.0),
                              //       ),
                              //       shadowColor: Colors.grey,
                              //       child: Stack(
                              //         children: [
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Expanded(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.end,
                              //                   children: [
                              //                     Expanded(
                              //                       child: ClipRRect(
                              //                         borderRadius:
                              //                             const BorderRadius.only(
                              //                                 topLeft:
                              //                                     Radius.circular(30),
                              //                                 topRight:
                              //                                     Radius.circular(30)),
                              //                         child: Image.asset(
                              //                           "assets/images/micro.jpg",
                              //                           width: double.infinity,
                              //                           fit: BoxFit.fill,
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Padding(
                              //                 padding: EdgeInsets.all(18.0),
                              //                 child: Text(
                              //                   "Microprocessors",
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Positioned(
                              //             bottom: 65,
                              //             left: 10,
                              //             child: ClipRRect(
                              //               borderRadius: BorderRadius.circular(30.0),
                              //               child: ColoredBox(
                              //                 color: Colors.grey.withOpacity(0.9),
                              //                 child: const Padding(
                              //                   padding: EdgeInsets.all(6.0),
                              //                   child: Text(
                              //                     "CC279",
                              //                     style: TextStyle(
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: double.infinity,
                              //   // width: min(MediaQuery.of(context).size.width * .50, 250) -
                              //   //     18,
                              //   height: 250,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(bottom: 8.0),
                              //     child: Card(
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(30.0),
                              //       ),
                              //       shadowColor: Colors.grey,
                              //       child: Stack(
                              //         children: [
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Expanded(
                              //                 child: Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.end,
                              //                   children: [
                              //                     Expanded(
                              //                       child: ClipRRect(
                              //                         borderRadius:
                              //                             const BorderRadius.only(
                              //                                 topLeft:
                              //                                     Radius.circular(30),
                              //                                 topRight:
                              //                                     Radius.circular(30)),
                              //                         child: Image.asset(
                              //                           "assets/images/coding.jpg",
                              //                           width: double.infinity,
                              //                           fit: BoxFit.fill,
                              //                         ),
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Padding(
                              //                 padding: EdgeInsets.all(18.0),
                              //                 child: Text(
                              //                   "Object Oriented Programming",
                              //                   overflow: TextOverflow.ellipsis,
                              //                   style: TextStyle(
                              //                     fontSize: 20,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //           Positioned(
                              //             bottom: 65,
                              //             left: 10,
                              //             child: ClipRRect(
                              //               borderRadius: BorderRadius.circular(30.0),
                              //               child: ColoredBox(
                              //                 color: Colors.grey.withOpacity(0.9),
                              //                 child: const Padding(
                              //                   padding: EdgeInsets.all(6.0),
                              //                   child: Text(
                              //                     "CC765",
                              //                     style: TextStyle(
                              //                       fontWeight: FontWeight.bold,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
              ),
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Wrap(
              //       children: [
              //         SizedBox(
              //           width: double.infinity,
              //           // width: min(MediaQuery.of(context).size.width * .50, 250) -
              //           //     18,
              //           height: 250,
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: 8.0),
              //             child: GestureDetector(
              //               onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) =>
              //                           const CourseDetails()),
              //                 );
              //               },
              //               child: Card(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(30.0),
              //                 ),
              //                 shadowColor: Colors.grey,
              //                 child: Stack(
              //                   children: [
              //                     Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Expanded(
              //                           child: Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.end,
              //                             children: [
              //                               Expanded(
              //                                 child: ClipRRect(
              //                                   borderRadius:
              //                                       const BorderRadius.only(
              //                                           topLeft:
              //                                               Radius.circular(30),
              //                                           topRight:
              //                                               Radius.circular(
              //                                                   30)),
              //                                   child: Image.asset(
              //                                     "assets/images/cloud.jpg",
              //                                     width: double.infinity,
              //                                     fit: BoxFit.fill,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         const Padding(
              //                           padding: EdgeInsets.all(18.0),
              //                           child: Text(
              //                             "Cloud Computing",
              //                             style: TextStyle(
              //                               fontSize: 20,
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     Positioned(
              //                       bottom: 65,
              //                       left: 10,
              //                       child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(30.0),
              //                         child: ColoredBox(
              //                           color: Colors.grey.withOpacity(0.9),
              //                           child: const Padding(
              //                             padding: EdgeInsets.all(6.0),
              //                             child: Text(
              //                               "CC313",
              //                               style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: double.infinity,
              //           // width: min(MediaQuery.of(context).size.width * .50, 250) -
              //           //     18,
              //           height: 250,
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: 8.0),
              //             child: Card(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(30.0),
              //               ),
              //               shadowColor: Colors.grey,
              //               child: Stack(
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             Expanded(
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                     const BorderRadius.only(
              //                                         topLeft:
              //                                             Radius.circular(30),
              //                                         topRight:
              //                                             Radius.circular(30)),
              //                                 child: Image.asset(
              //                                   "assets/images/ai.jpg",
              //                                   width: double.infinity,
              //                                   fit: BoxFit.fill,
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       const Padding(
              //                         padding: EdgeInsets.all(18.0),
              //                         child: Text(
              //                           "Artificial Intelligence",
              //                           style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Positioned(
              //                     bottom: 65,
              //                     left: 10,
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(30.0),
              //                       child: ColoredBox(
              //                         color: Colors.grey.withOpacity(0.9),
              //                         child: const Padding(
              //                           padding: EdgeInsets.all(6.0),
              //                           child: Text(
              //                             "CC526",
              //                             style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: double.infinity,
              //           // width: min(MediaQuery.of(context).size.width * .50, 250) -
              //           //     18,
              //           height: 250,
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: 8.0),
              //             child: Card(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(30.0),
              //               ),
              //               shadowColor: Colors.grey,
              //               child: Stack(
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             Expanded(
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                     const BorderRadius.only(
              //                                         topLeft:
              //                                             Radius.circular(30),
              //                                         topRight:
              //                                             Radius.circular(30)),
              //                                 child: Image.asset(
              //                                   "assets/images/micro.jpg",
              //                                   width: double.infinity,
              //                                   fit: BoxFit.fill,
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       const Padding(
              //                         padding: EdgeInsets.all(18.0),
              //                         child: Text(
              //                           "Microprocessors",
              //                           style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Positioned(
              //                     bottom: 65,
              //                     left: 10,
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(30.0),
              //                       child: ColoredBox(
              //                         color: Colors.grey.withOpacity(0.9),
              //                         child: const Padding(
              //                           padding: EdgeInsets.all(6.0),
              //                           child: Text(
              //                             "CC279",
              //                             style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: double.infinity,
              //           // width: min(MediaQuery.of(context).size.width * .50, 250) -
              //           //     18,
              //           height: 250,
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: 8.0),
              //             child: Card(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(30.0),
              //               ),
              //               shadowColor: Colors.grey,
              //               child: Stack(
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Expanded(
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             Expanded(
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                     const BorderRadius.only(
              //                                         topLeft:
              //                                             Radius.circular(30),
              //                                         topRight:
              //                                             Radius.circular(30)),
              //                                 child: Image.asset(
              //                                   "assets/images/coding.jpg",
              //                                   width: double.infinity,
              //                                   fit: BoxFit.fill,
              //                                 ),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       const Padding(
              //                         padding: EdgeInsets.all(18.0),
              //                         child: Text(
              //                           "Object Oriented Programming",
              //                           style: TextStyle(
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   Positioned(
              //                     bottom: 65,
              //                     left: 10,
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(30.0),
              //                       child: ColoredBox(
              //                         color: Colors.grey.withOpacity(0.9),
              //                         child: const Padding(
              //                           padding: EdgeInsets.all(6.0),
              //                           child: Text(
              //                             "CC765",
              //                             style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

Future<http.Response> GetCourses(String id) {
  return http.post(
    Uri.parse(
        "http://smart-campus-env-1.eba-2gujdmuy.eu-west-3.elasticbeanstalk.com/api/GetCourses/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}'
    },
    body: jsonEncode(<String, String>{
      "instructor_id": id,
      "course_code": "",
      "class_no": ""
    }),
  );
}
