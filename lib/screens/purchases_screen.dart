import 'package:bennbuy/helpers/authentication.dart';
import 'package:bennbuy/methods.dart';
import 'package:bennbuy/models/order.dart';
import 'package:bennbuy/screens/purchase_detail_screen.dart';
import 'package:bennbuy/widgets/bottom_nav_bar.dart';
import 'package:bennbuy/widgets/custom_widgets.dart';
import 'package:bennbuy/widgets/header/seamless_appbar.dart';
import 'package:flutter/material.dart';

class PurchasesScreen extends StatefulWidget {
  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  double screenWidth;
  List<Order> order;
  bool orderLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPurchasedOrders( Authentication.userId ).then((response){
      setState(() {
        order = response;
        orderLoaded = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: seamlessAppBar( context, orderTitle: 'Purchases' ),
      body: orderLoaded ? ListView.builder(
        itemCount: order.length,
        itemBuilder: (context, i){
          return _buildListItem(order[i]);
        }
      ) : Container(),
    );
  }

  Widget _buildListItem( Order order ){
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]), bottom: BorderSide(color: Colors.grey[100])),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            offset: Offset(1, 1)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PurchaseDetailScreen(order)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Order #${order.number}',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),

                  Container(
                    width: screenWidth * 0.4,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.navigate_next),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          SizedBox(height: 5,),
          _orderMeta('Date: ', dateConverter(order.dateCreated)),
          SizedBox(height: 5,),
          _orderMeta('Total: ', '\$' + order.total),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Container(
                width: screenWidth * 0.2,
                child: Text('Status: ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  )
                ),
              ),
              Text(order.status.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _orderMeta(String title, value){
    return Row(
      children: <Widget>[
        Container(
          width: screenWidth * 0.2,
          child: Text(title),
        ),
        Text(value)
      ],
    );
  }
}
