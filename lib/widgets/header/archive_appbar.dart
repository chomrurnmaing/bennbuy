import 'package:bennbuy/helpers/cart_helper.dart';
import 'package:flutter/material.dart';


class ArchiveAppBar extends StatefulWidget {
  @override
  _ArchiveAppBarState createState() => _ArchiveAppBarState();
}

class _ArchiveAppBarState extends State<ArchiveAppBar> {
  List _cities = ["popularity", "average rating", "latest", "price: low to high", "price: high to low"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    selectedItem = _cities[0];
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      selectedItem = selectedCity;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(DropdownMenuItem(
        value: city,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(city, overflow: TextOverflow.fade,),
        )
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      bottom: PreferredSize(
        child: Container(
          alignment: Alignment.topCenter,
          height: 60,
          child: Column(
            children: <Widget>[
              Container(
                height: 1,
                decoration: BoxDecoration(
                    color: Colors.grey[200]
                ),
              ),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: screenWidth/2,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              padding: EdgeInsets.all(0),
                              child: DropdownButton(
                                value: selectedItem,
                                items: _dropDownMenuItems,
                                onChanged: changedDropDownItem,
                              ),
                            ),
                          ),
                        ),
                        FlatButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/product-filter');
                            },
                            child: Text('Filter')
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
        preferredSize: Size(double.infinity, 60)),
    );
  }
}
