import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_example/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_application_bloc_example/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/ui/product_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listener: (context, state) {
            if (state is CartRemovedActionState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('item removed successfully in cartList ')));
            }
          },
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is! CartActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartLoadingState:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );

              case CartLoadingSuccessState:
                final successState = state as CartLoadingSuccessState;
                return ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartTileWidget(
                          productsDataModel: successState.cartItems[index],
                          cartBloc: cartBloc);
                    });

              case CartLoadingFailureState:
                return const Scaffold(
                  body: Center(child: Text('Error')),
                );
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
