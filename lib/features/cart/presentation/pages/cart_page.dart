import 'package:catalog_app/core/utils/toast_helper.dart';
import 'package:catalog_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Cart Page", style: TextStyle(color: Colors.white)),
      ),

      body: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, CartState state) {
          if (state is CartLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartLoadedState) {
            if (state.products.isEmpty) {
              return Center(child: Text("product not found"));
            }
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final cartItem = state.products[index];
                final product = cartItem.productEntity;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.images[0],
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                        RemoveItemToCartEvent(
                                          product.id,
                                          state.products,
                                        ),
                                      );
                                      ToastMessage.showToast(
                                        context,
                                        'cart removed successfully',
                                      );
                                    },
                                    child: Icon(Icons.remove),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              Text(
                                product.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),

                              const SizedBox(height: 6),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),

                                  Text(
                                    "Qty: ${cartItem.quantity}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is CartError) {
            return Center(child: Text(state.message));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
