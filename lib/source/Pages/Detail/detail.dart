import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  String image;
  String name;
  String desc;
  Detail({Key? key, required this.image, required this.desc, required this.name}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.image,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, exception, stackTrace) {
                  return Container(
                    // width: 120,
                    height: 350,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
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
              Positioned(
                left: 16,
                top: 35,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(60)),
                    child: FaIcon(FontAwesomeIcons.chevronLeft, size: 23, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            widget.name,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 20,
                            child: RatingBar.builder(
                              initialRating: 4,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemSize: 23,
                              unratedColor: Colors.white,
                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (_) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DESCRIPTION',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Divider(thickness: 3, color: Colors.grey[300]),
                      const SizedBox(height: 12),
                      Text(
                        widget.desc,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Harga',
                      style: GoogleFonts.roboto(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Rp. 35.000',
                      style: GoogleFonts.roboto(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFFC900),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.shoppingBag,
                            size: 25,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Masukan Keranjang',
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0)
        ],
      ),
    );
  }
}
