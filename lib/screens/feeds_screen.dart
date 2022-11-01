// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shoping_app_api/models/products_model.dart';
import '../widgets/feeds_widget.dart';

class FeedsScreen extends StatelessWidget {
  List<ProductsModel> productsList;

  FeedsScreen({
    required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 4,
        title: const Text('All Products'),
      ),
      body: GridView.builder(
          itemCount: productsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 2 / 3.1),
          itemBuilder: (ctx, index) {
            final prodM = productsList[index];
            return FeedsWidget(prodM: prodM,);
          }),
    );
  }
}
