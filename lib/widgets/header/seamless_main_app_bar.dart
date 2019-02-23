import 'package:bennbuy/helpers/cart_helper.dart';
import 'package:flutter/material.dart';

Widget seamlessMainAppBar( BuildContext context, {String orderTitle} ){
  return AppBar(
    centerTitle: true,
    leading: IconButton(
        icon: Icon(Icons.search),
        onPressed: (){
          Navigator.pushNamed(context, '/search');
        }),
    title: Text(orderTitle != null ? orderTitle : 'BENNBUY',
      style: TextStyle(
          fontFamily: 'Muli',
          fontWeight: FontWeight.w300
      ),),
    actions: <Widget>[
      Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.pushNamed(context, '/cart');
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(3.0),
              margin: EdgeInsets.only(left: 26.0),
              child: Text(CartHelper.cartCount.toString(),
                style: TextStyle(
                    color: Colors.white
                ),),
            )
          ],
        ),
      )
    ],
  );
}