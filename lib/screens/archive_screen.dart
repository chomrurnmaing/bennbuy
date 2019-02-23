import 'package:bennbuy/widgets/bottom_nav_bar.dart';
import 'package:bennbuy/widgets/category/sub_categories.dart';
import 'package:bennbuy/widgets/custom_widgets.dart';
import 'package:bennbuy/widgets/header/archive_appbar.dart';
import 'package:bennbuy/widgets/header/main_appbar.dart';
import 'package:bennbuy/widgets/products/sliver_product_grid.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArchiveScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final bool showAll;
  ArchiveScreen(this.categoryId, this.categoryName, this.showAll);
  
  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  String apiUrl;
  bool loaded;
  bool hasChild;
  List _catsList;

  @override
  void initState() {

    hasChild=false;

    if ( widget.showAll == false ) {
      loaded=false;

      apiUrl = 'https://bennbuy.com/wp-json/wc/v3/products/categories?parent=${widget.categoryId}&per_page=100&consumer_key=ck_05bbedd9f47eb253d46b414bff1266747b70ce53&consumer_secret=cs_4775677bde4935bec50f6e0b95cf745dd5e220c2';
      _checkSubCategories( apiUrl );

    } else {
      loaded=true;
    }


    super.initState();
  }

  _checkSubCategories( apiUrl ) async {
    setState(() {
      loaded = false;
      hasChild = false;
    });
    final response =
    await http.get(apiUrl);
    if (response.statusCode == 200) {
      _catsList = json.decode(response.body) as List;

      setState(() {

        loaded = true;

        if ( _catsList.length > 0 ) {

          hasChild = true;

        } else {

          hasChild = false;

        }
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: loaded == false
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : hasChild
            ? SubCategories( widget.categoryId, widget.categoryName, _catsList )
            : SliverProductGrid( widget.categoryId )
      ),
    );
  }

}
