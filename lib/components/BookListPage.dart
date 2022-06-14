// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:e_balbharati/components/BookPDFViewPage.dart';
import 'package:e_balbharati/components/errorPage.dart';
import 'package:e_balbharati/modules/EBooksDataModule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class BookListPage extends StatefulWidget {
  final String classVal;
  const BookListPage({Key? key, required this.classVal}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  int timer = 800, offset = 0;

  Future<List<Marathi>> loadData() async {
    List<Marathi> eBooks;
    String server ="https://e-balbharati-default-rtdb.firebaseio.com/e-Balbharati/" +"${widget.classVal}" +"/marathi.json";
    var res = await http.get(Uri.parse(server));
    var data = jsonDecode(res.body);
    eBooks = data.map<Marathi>((json) => Marathi.fromJson(json)).toList();
    print(eBooks.length);
    return eBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "ई-बालभारती",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: bookCard(snapshot),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: ErrorPage(),
              );
            } else {
              return loadingWidget();
            }
          }),
    );
  }

  Widget loadingWidget() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: 8,
        itemBuilder: (BuildContext ctx, index) {
          offset += 50;
          timer = 800 + offset;
          print(timer);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              period: Duration(milliseconds: timer),
              child: box(),
            ),
          );
        });
  }

  Widget box() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      width: 100,
      color: Colors.grey,
    );
  }

  Widget bookCard(booksData) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        itemCount: booksData.data.length,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookPDFView(
                            bookLink: booksData.data[i].link,
                            title: booksData.data[i].bookName,
                          )));
            },
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.amber)),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(booksData.data[i].bookCover),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      booksData.data[i].bookName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5,
          mainAxisExtent: 264,
        ),
      ),
    );
  }
}
