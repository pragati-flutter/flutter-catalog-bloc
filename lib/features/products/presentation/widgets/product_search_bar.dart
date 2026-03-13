/*
import 'package:catalog_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchItems = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchItems,
        decoration: InputDecoration(

          hintText: "Search Products",
          prefixIcon: InkWell(
             onTap: (){
               context.read<ProductBloc>().add(
                 SearchProductEvent(searchItems.text),
               );
             },
              child: const Icon(Icons.search, color: Colors.indigo)),
          border: const OutlineInputBorder(),
        ),

      ),
    );
  }
}*/

import 'package:catalog_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchBar extends StatefulWidget {
  const ProductSearchBar({super.key});

  @override
  State<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends State<ProductSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search Products",
          prefixIcon: InkWell(
              onTap: (){
                context.read<ProductBloc>().add(SearchProductEvent(searchController.text));

              },
              child: const Icon(Icons.search, color: Colors.indigo)),

          // clear button
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchController.clear();

              // reload original products
              context.read<ProductBloc>().add(GetProductEvent());
            },
          ),

          border: const OutlineInputBorder(),
        ),

      ),
    );
  }
}
