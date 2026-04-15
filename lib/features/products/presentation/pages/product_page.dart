import 'dart:io';

import 'package:catalog_app/core/routes/app_routes.dart';
import 'package:catalog_app/core/utils/toast_helper.dart';
import 'package:catalog_app/features/cart/domain/entites/cart_entity.dart';
import 'package:catalog_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:catalog_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_search_bar.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.cartPage);
              context.read<CartBloc>().add(GetCartItems());
            },
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            print("state is productLoading state ");
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoadedState) {
            print("state is productLoadedState");
            return Column(
              children: [
                ProductSearchBar(),
                Expanded(
                  child: GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.productDetails,
                              arguments: product.id,
                            );

                          },
                          onDoubleTap: () {
                            final cartItem = CartEntity(
                              productEntity: product,
                              quantity: 1,
                            );
                            context.read<CartBloc>().add(
                              AddItemsToCartEvent(cartItem: cartItem),
                            );
                            ToastMessage.showToast(
                              context,
                              "item added successfully",
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.indigo.withAlpha(50),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.indigo.shade600,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child:
                                      (product.localImagePath.isNotEmpty &&
                                          File(
                                            product.localImagePath,
                                          ).existsSync())
                                      ? Image.file(
                                          File(product.localImagePath),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : (product.images.isNotEmpty
                                            ? Image.network(
                                                product.images[0],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                errorBuilder: (_, __, ___) {
                                                  return const Icon(
                                                    Icons.broken_image,
                                                    size: 60,
                                                  );
                                                },
                                              )
                                            : const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 60,
                                                ),
                                              )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${product.price}",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is SearchProductError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(GetProductEvent());
                    },
                    child: const Text("Back to Products"),
                  ),
                ],
              ),
            );
          }

          if (state is ProductError) {
            print("state is ProductError");
            return Center(child: Text(state.message));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
