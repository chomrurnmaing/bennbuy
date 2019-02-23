import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class ProductContent extends StatelessWidget{

  final String content;
  ProductContent(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text('DETAILS & CARE',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Divider(),

          Container(
            alignment: Alignment.centerLeft,
            child: HtmlView(
              data: content,
              padding: EdgeInsets.all(0),
            ),
          )
        ],
      ),
    );
  }
}
