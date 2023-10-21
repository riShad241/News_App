import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/News_chanals_Model.dart';
import 'package:news_app/models/News_chanals_headlines.dart';
import 'package:news_app/screen/CategoryNewsScreen.dart';
import 'package:news_app/screen/description_page.dart';
import 'package:news_app/view_model/news_view_models.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNewsScreen()));
        }, icon: Image.asset('images/category_icon.png',
          height: 30,
          width: 30,
        ),),
        title:const Text(
          'News',
         style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.3,
                width:  width,
                child: FutureBuilder<NewsChanalsHeadlinesModels>(
                  future: newsViewModel.FeathcNewsHeadlineApi(),
                  builder: (BuildContext context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    }else{
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.articles?.length ?? 0,
                          itemBuilder: (context, index){
                            DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * .9,
                                  padding: EdgeInsets.symmetric(horizontal: height * .02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data?.articles?[index].urlToImage.toString() ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>Container(child: spinkit2,),
                                      errorWidget: (context, url, error) =>const  Icon(Icons.error, color: Colors.red,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 1,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          DescriotionPage(article: snapshot.data!.articles![index],
                                          )));
                                    },
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        height: height * .12,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * .7,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                                child: Text(snapshot.data?.articles?[index].title.toString() ?? '',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 3,right: 3,bottom: 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot.data?.articles?[index].source!.name.toString() ?? '',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.white),
                                                  ),
                                                  const SizedBox(width: 60,),
                                                  Text(format.format(datetime),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w700,color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  },
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<NewsChanalsModels>(
                  future: newsViewModel.FeathcNewsApi(),
                  builder: (BuildContext context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    }else{
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index){
                            DateTime datetime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // How far the shadow should spread
                                    blurRadius: 5, // How blurry the shadow should be
                                    offset:const Offset(0, 3), // Offset in the x and y directions
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 70,
                                          width: 100,
                                            color: Colors.transparent,
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>Container(child: spinkit2,),
                                            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red,),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 2,),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(snapshot.data!.articles![index].title.toString(),style:const  TextStyle(fontSize: 16),),
                                            Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(snapshot.data!.articles![index].source!.name.toString(),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.w500,color: Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 60,),
                                                  Expanded(
                                                    child: Text(format.format(datetime),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.w700,color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
const spinkit2 = SpinKitCircle(
  size: 50,
  color: Colors.blue,
);
