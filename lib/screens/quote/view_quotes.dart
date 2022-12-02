import 'package:flutter/material.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';
import 'list_authors.dart';
import 'list_quotes.dart';


class ViewQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Motivational Quotes'),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: const Icon(
                Icons.bookmark_added,
                color: Colors.purple,
              ),
              tileColor: Colors.purple[200],
              title: textReg('"${quotes[index]}"', 24, Colors.black),
              subtitle: Padding(
                padding: const EdgeInsets.all(10.0),
                child: textBold('By: ' + author[index], 12, Colors.black),
              ),
            ),
          );
        }),
      ),
    );
  }
}
