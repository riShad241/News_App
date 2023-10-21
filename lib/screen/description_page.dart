import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/News_chanals_headlines.dart';
import 'package:news_app/models/articalModel.dart';
class DescriotionPage extends StatefulWidget {
  final Articles article;
  const DescriotionPage({Key? key, required this.article}) : super(key: key);

  @override
  State<DescriotionPage> createState() => _DescriotionPageState();
}

class _DescriotionPageState extends State<DescriotionPage> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Description ',style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black,),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child:  CachedNetworkImage(
                imageUrl: widget.article.urlToImage.toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) =>Container(child: spinkit2,),
                errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.article.title.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(' Source : ${widget.article.source.toString()}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800),),
                Text(' pusblish : ${widget.article.publishedAt.toString()}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.article.description.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
          ),
        ],
      ),
    );
  }
}
const spinkit2 = SpinKitCircle(
  size: 50,
  color: Colors.blue,
);