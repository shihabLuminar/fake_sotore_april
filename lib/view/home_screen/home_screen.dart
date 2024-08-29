import 'package:flutter/material.dart';
import 'package:folder_structure_sample_april/controller/home_screen_controller.dart';
import 'package:folder_structure_sample_april/view/product_details_screen/product_details_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().getCategoris();
        await context.read<HomeScreenController>().getAllProducts();
      },
    );
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelectedIndex(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final categoryWidth = screenWidth /
        3; // Adjust this width based on the item width (container + padding)
    final targetOffset =
        (index * categoryWidth) - (screenWidth / 2) + (categoryWidth / 2);

    _scrollController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
        ),
        actions: [
          Stack(
            children: [
              Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 40,
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.black,
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, homeprovider, child) => homeprovider
                .isCategoriesLoading // for showing loading state of categories
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // #1
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(.2)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Search anything",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: List.generate(
                          homeprovider.categoriesList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<HomeScreenController>()
                                    .onCategorySelection(index);
                                _scrollToSelectedIndex(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: index ==
                                            homeprovider.selectedCategoryIndex
                                        ? Colors.black
                                        : Colors.grey.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  homeprovider.categoriesList[index]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: index ==
                                              homeprovider.selectedCategoryIndex
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: homeprovider
                              .isProductsLoading // for showing loading state of products
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              itemCount: homeprovider.productsList.length,
                              padding: EdgeInsets.all(20),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreen(
                                                productId: homeprovider
                                                    .productsList[index].id!),
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(.2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(homeprovider
                                                  .productsList[index].image
                                                  .toString()))),
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.7),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.favorite_outline,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      maxLines: 1,
                                      homeprovider.productsList[index].title
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(homeprovider.productsList[index].price
                                        .toString()),
                                  ],
                                ),
                              ),
                            ))
                ],
              ),
      ),
    );
  }
}
