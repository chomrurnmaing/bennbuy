import 'package:bennbuy/helpers/cart_helper.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      elevation: 2.0,
      floating: true,
      pinned: false,
      centerTitle: true,
      title: Text('BENNBUY',
        style: TextStyle(
            fontFamily: 'Muli',
            fontWeight: FontWeight.w300
        ),),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.pushNamed(context, '/search');
            }),
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
}
