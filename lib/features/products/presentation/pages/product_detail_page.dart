import 'package:catalog_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailLoadedState) {
            return Column(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(state.product.images![0]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${state.product.description}'),
                ),
                buildPadding('price', '${state.product.price}'),
                buildPadding('rating', '${state.product.rating}*'),
              ],
            );
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }

  Padding buildPadding(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text1,
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(text2),
            ],
          ),
        ],
      ),
    );
  }
}
