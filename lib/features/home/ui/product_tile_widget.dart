import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_example/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_bloc_example/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_application_bloc_example/models/product_data_model.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductsDataModel productsDataModel;
  final HomeBloc homeBloc;
  final WishlistBloc wishlistBloc;

  const ProductTileWidget({
    Key? key,
    required this.productsDataModel,
    required this.homeBloc,
    required this.wishlistBloc,
  }) : super(key: key);

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productsDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.productsDataModel.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Category: ${widget.productsDataModel.category}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${widget.productsDataModel.price}', style: const TextStyle(fontSize: 15)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () {
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });

                      if (isWishlisted) {
                        widget.homeBloc.add(
                          HomeProductWishlistButtonClickedEvent(
                            clickedProduct: widget.productsDataModel,
                          ),
                        );
                      } else {
                        widget.wishlistBloc.add(
                          WishlistRemoveFromWishlistEvent(widget.productsDataModel),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {
                      widget.homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                          clickedProduct: widget.productsDataModel,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
