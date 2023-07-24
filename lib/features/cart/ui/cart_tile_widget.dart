import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_example/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_bloc_example/models/product_data_model.dart';

class CartTileWidget extends StatelessWidget {
  final ProductsDataModel productsDataModel;
  final CartBloc cartBloc;
  const CartTileWidget(
      {super.key, required this.productsDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productsDataModel.imageUrl)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          productsDataModel.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
       
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('\$${productsDataModel.price}',
              style: const TextStyle(fontSize: 15)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  cartBloc.add(CartRemoveFromCartEvent(productsDataModel));
                },
              ),
            ],
          )
        ]),
      ]),
    );
  }
}
