import 'dart:convert';

class Marathi {
    Marathi({
        required this.bookName,
        required this.bookCover,
        required this.link,
    });

    String bookName;
    String bookCover;
    String link;

    factory Marathi.fromJson(Map<String, dynamic> json) => Marathi(
        bookName: json["bookName"],
        bookCover: json["bookCover"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "bookName": bookName,
        "bookCover": bookCover,
        "link": link,
    };
}
