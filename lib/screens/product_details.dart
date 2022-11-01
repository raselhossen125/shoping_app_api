// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app_api/models/products_model.dart';
import '../consts/global_colors.dart';

class ProductDetails extends StatefulWidget {
  ProductsModel singleProd;

  ProductDetails({
    required this.singleProd,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              const BackButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      widget.singleProd.category!.name!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            widget.singleProd.title!,
                            textAlign: TextAlign.start,
                            style: titleStyle,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                                text: '\$',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromRGBO(33, 150, 243, 1)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.singleProd.price!.toDouble().toString(),
                                      style: TextStyle(
                                          color: lightTextColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.4,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return FancyShimmerImage(
                      width: double.infinity,
                      imageUrl: widget.singleProd.images![0],
                      boxFit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: widget.singleProd.images!.length,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.red,
                    ),
                  ),
                  // control: const SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: titleStyle),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      widget.singleProd.description!,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
