import 'package:bennbuy/helpers/authentication.dart';
import 'package:bennbuy/helpers/cart_helper.dart';
import 'package:bennbuy/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import './screens/shop_screen.dart';

void main(){
  runApp(new MainApp());
}

class MainApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp>{

  getCartCount() {
    http.get('https://bennbuy.com/wp-json/wc/v2/cart/count-items?consumer_key=ck_05bbedd9f47eb253d46b414bff1266747b70ce53&consumer_secret=cs_4775677bde4935bec50f6e0b95cf745dd5e220c2').then((response){
      if ( response.statusCode == 200 ){
        setState(() {
          CartHelper.cartCount = int.parse(response.body);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartCount();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(250, 250, 250, 1.0),
        fontFamily: 'Muli',
        backgroundColor: Colors.white,
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'BENNBUY',
      routes: routes(),

      onGenerateRoute: (RouteSettings settings) => generateRoutes(settings),

      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => ShopScreen()
        );
      },
    );
  }

}
