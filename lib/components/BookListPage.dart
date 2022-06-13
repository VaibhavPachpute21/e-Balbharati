// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:e_balbharati/modules/EBooksDataModule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookListPage extends StatefulWidget {
  final String classVal;
  const BookListPage({Key? key, required this.classVal}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  Future<List<Marathi>> loadData() async {
    List<Marathi> eBooks;
    String server =
        "https://e-balbharati-default-rtdb.firebaseio.com/e-Balbharati/" +
            "${widget.classVal}" +
            "/marathi.json";
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
        // bottom: PreferredSize(
        //   child: Container(
        //     child: const Text(
        //       "कृपया आपली इयत्ता निवडा",
        //       style: TextStyle(fontSize: 18),
        //     ),
        //   ),
        //   preferredSize: const Size(50, 15),
        // ),
      ),
      body: FutureBuilder(
          future: loadData(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: bookCard(
                    snapshot), //Text(snapshot.data!.length.toString()),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
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
            highlightColor: Colors.amber,
            focusColor: Colors.amber,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(2),
                    height: 290,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(2),
                        image:DecorationImage(image: NetworkImage(booksData.data[i].bookCover),fit: BoxFit.fitWidth )
                        ),
                  ),
                ),
                Text(
                        booksData.data[i].bookName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
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
