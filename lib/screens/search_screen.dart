import 'package:bennbuy/methods.dart';
import 'package:bennbuy/models/product_search.dart';
import 'package:bennbuy/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _filter = new TextEditingController();
  FocusNode _textFocus = new FocusNode();
  String keyword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filter.addListener(onChange);
    _textFocus.addListener(onChange);
  }

  void onChange(){

    setState(() {
      keyword = _filter.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        title: TextField(
          controller: _filter,
          focusNode: _textFocus,
          decoration: new InputDecoration(
            hintText: 'Search...',
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder<List<ProductSearch>>(
        future: productSearch(keyword),
        builder: (context, snapshot){
          if( snapshot.hasData ) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i){
                return ListTile(
                  onTap: (){
                    Navigator.pushNamed(context, '/product-detail/${snapshot.data[i].id}');
                  },
                  title: Text(snapshot.data[i].title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                );
              },
            );

          } else if ( snapshot.hasError ) {
            return Container();
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
