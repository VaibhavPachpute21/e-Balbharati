// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookPDFView extends StatefulWidget {
  final String bookLink;
  final String title;
  const BookPDFView({Key? key, required this.bookLink, required this.title})
      : super(key: key);

  @override
  State<BookPDFView> createState() => _BookPDFViewState();
}

class _BookPDFViewState extends State<BookPDFView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SfPdfViewer.network(widget.bookLink,),
    );
  }
}
