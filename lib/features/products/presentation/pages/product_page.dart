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
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoadedState) {
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.productDetails,
                              arguments: state.products[index].id,
                            );
                          },
                          onDoubleTap: () {
                            final cartItem = CartEntity(
                              productEntity: state.products[index],
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
                            height: 600,
                            decoration: BoxDecoration(
                              color: Colors.indigo.withAlpha(50),
                              borderRadius: BorderRadius.circular(10),

                              border: Border.all(
                                color: Colors.indigo.shade600,
                                width: 1,
                              ),
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Image.asset(state.products[index].images![index]),
                                Expanded(
                                  child: Image.network(
                                    state.products[index].images![0],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          state.products[index].title,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${state.products[index].price}",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
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
            return Center(child: Text(state.message));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
