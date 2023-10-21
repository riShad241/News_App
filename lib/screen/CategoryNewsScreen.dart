import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/NewsCategory.dart';
import 'package:news_app/screen/Categorydescription_page.dart';
import 'package:news_app/view_model/news_view_models.dart';

class CategoryNewsScreen extends StatefulWidget {
  const CategoryNewsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String CategoryName = 'International';
  List<String> CategoryList = [
    'International',
    'Bangladesh',
    'Bangladesh Health',
    'Bangladesh Sports',
    'Bangladesh ICT',
    'Bangladesh Science',
  ];
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Category News',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: CategoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            CategoryName = CategoryList[index];
                            setState(() {});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CategoryName == CategoryList[index]
                                    ? Colors.blue
                                    : Colors.grey),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                  child: Text(CategoryList[index].toString())),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(height: 70,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        fillColor: Colors.white70,
                        focusColor: Colors.blue,
                        filled: true,
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<NewsCategoryModels>(
                  future: newsViewModel.FeatchCategoryApi(CategoryName) ,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data?.articles?.length ?? 0,
                          itemBuilder: (context, index) {
                            DateTime datetime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryDescriotionPage(article: snapshot.data!.articles![index])));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      // Shadow color
                                      spreadRadius: 5,
                                      // How far the shadow should spread
                                      blurRadius: 5,
                                      // How blurry the shadow should be
                                      offset: Offset(0, 3), // Offset in the x and y directions
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
                                              imageUrl: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                    child: spinkit2,
                                                  ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data?.articles?[index].title ?? ''
                                                    .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(3.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data?.articles?[index].source?.name.toString() ?? '',
                                                        maxLines: 2,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style:
                                                        GoogleFonts.poppins(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            color:
                                                            Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 60,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        format.format(datetime),
                                                        maxLines: 2,
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        style:
                                                        GoogleFonts.poppins(
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            color:
                                                            Colors.black),
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