// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shoping_app_api/api_services/api_handeler.dart';
import 'package:shoping_app_api/models/products_model.dart';
import 'package:shoping_app_api/screens/users_screen.dart';
import '../consts/global_colors.dart';
import '../widgets/appbar_icons.dart';
import '../widgets/feeds_widget.dart';
import '../widgets/sale_widget.dart';
import 'categories_screen.dart';
import 'feeds_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textEditingController = TextEditingController();
  List<ProductsModel> productsList = [];

  @override
  void didChangeDependencies() async {
    getProducts();
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await ApiHandeler.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            // elevation: 4,
            title: const Text('Home'),
            leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const CategoriesScreen(),
                  ),
                );
              },
              icon: IconlyBold.category,
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const UsersScreen(),
                    ),
                  );
                },
                icon: IconlyBold.user3,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: Icon(
                        IconlyLight.search,
                        color: lightIconsColor,
                      )),
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.25,
                          child: Swiper(
                            itemCount: 3,
                            itemBuilder: (ctx, index) {
                              return const SaleWidget();
                            },
                            autoplay: true,
                            pagination: const SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                    color: Colors.white,
                                    activeColor: Colors.red)),
                            // control: const SwiperControl(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Latest Products",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              AppBarIcons(
                                  function: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: FeedsScreen(
                                                productsList: productsList)));
                                  },
                                  icon: IconlyBold.arrowRight2),
                            ],
                          ),
                        ),
                        productsList != null
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productsList.length >= 10 ? 10 : productsList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 2 / 3.1),
                                itemBuilder: (ctx, index) {
                                  final prodM = productsList[index];
                                  return FeedsWidget(
                                    prodM: prodM,
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                    color: Colors.red),
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
