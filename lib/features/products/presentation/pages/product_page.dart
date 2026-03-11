import 'package:catalog_app/core/routes/app_routes.dart';
import 'package:catalog_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catalog App",style: TextStyle(
        color: Colors.white
      ),
      ),
      backgroundColor: Colors.pink,
        actions: [
          Icon(Icons.shopping_cart,color: Colors.white,)
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoadedState) {
            return GridView.builder(
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
                    onTap: (){
                     Navigator.pushNamed(context,AppRoutes.productDetails,arguments:state.products[index].id );
                    },
                    child: Container(
                      height: 600,
                      decoration: BoxDecoration(
                        color: Colors.indigo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),

                        border: Border.all(color: Colors.indigo.shade600, width: 1),
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
