import 'package:bennbuy/models/product_category.dart';
import 'package:bennbuy/screens/archive_screen.dart';
import 'package:bennbuy/widgets/header/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class SubCategories extends StatefulWidget {

  final int parentId;
  final String parentName;
  final List categories;
  SubCategories( this.parentId, this.parentName, this.categories );

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  
  HtmlUnescape unescape = new HtmlUnescape();
  
  @override
  void initState() {
    // TODO: implement initState
    widget.categories.insert(0, {'id': widget.parentId, 'name': 'All ${widget.parentName}'});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: <Widget>[
        MainAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
              widget.categories.map(( cat ){

                return Container(
                  child: ListTile(
                    onTap: (){
                      if ( cat['id']==widget.parentId ) {
                        Navigator.pushNamed(context, '/archive/${cat['id']}/${cat['name']}/true');
                      } else {
                        Navigator.pushNamed( context, '/archive/${cat['id']}/${cat['name']}/false' );
                      }
                    },
                    title: Text( unescape.convert(cat['name']) ),
                  ),
                );
              }).toList()
          ),
        )
      ],
    );
  }
}
