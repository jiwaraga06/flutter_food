import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foods/source/Pages/Detail/detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var loading = false;
  var menu = [];
  void getMenu() async {
    setState(() {
      loading = true;
    });
    try {
      var url = Uri.parse('http://18.221.132.15:7000/foods');
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      print(json);
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
          menu = json;
        });
      } else {
        setState(() {
          loading = false;
        });
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: json.toString(),
        );
      }
    } catch (e) {
      print('Error : $e');
      CoolAlert.show(context: context, type: CoolAlertType.error, text: e.toString());
    }
  }

  Future refresh() async {
    menu.clear();
    Future.delayed(Duration(seconds: 2));
    getMenu();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMenu();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const Center(child: FaIcon(FontAwesomeIcons.utensils, color: Colors.black)),
        title: Text('Menu', style: GoogleFonts.roboto(color: Colors.black, fontSize: 23, fontWeight: FontWeight.w600)),
        actions: const [
          Center(
              child: Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: FaIcon(FontAwesomeIcons.shoppingBag, color: Color(0xFFFFC900)),
          )),
        ],
      ),
      body: Container(
        child: loading == true
            ? ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 120,
                            height: 120,
                            child: Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 236, 236, 236),
                              highlightColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.grey[200],
                                ),
                              ),
                            )),
                        const SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 180,
                                height: 20,
                                child: Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 236, 236, 236),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 12),
                            SizedBox(
                                width: 150,
                                height: 20,
                                child: Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 236, 236, 236),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 12),
                            SizedBox(
                                width: 150,
                                height: 20,
                                child: Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 236, 236, 236),
                                  highlightColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                })
            : RefreshIndicator(
                backgroundColor: Color(0xFFFFC900),
                color: Colors.black,
                onRefresh: refresh,
                child: ListView.builder(
                  itemCount: menu.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = menu[index];
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Detail(image: data['image'], desc: data['desc'], name: data['name'])));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  data['image'],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Container(
                                      width: 120,
                                      height: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.grey[200],
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.question,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: GoogleFonts.roboto(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        ignoreGestures: true,
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (_) {},
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Rp. 35.000',
                                      style: GoogleFonts.roboto(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Color(0xFFFFC900), borderRadius: BorderRadius.circular(60)),
                                  child: const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.black, size: 23)),
                              const SizedBox(width: 6.0),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
