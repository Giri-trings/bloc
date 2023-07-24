import 'package:flutter/material.dart';

import 'package:flutter_application_bloc_example/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_application_bloc_example/features/wishlist/ui/wishlist_tile_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('wishlist'),
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listenWhen: (previous, current) => current is WishlistActionState,
          buildWhen: (previous, current) => current is! WishlistActionState,
          listener: (context, state) {
            if (state is WishListRemovedActionState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('item removed successfully in wishlist ')));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishListLoadingState:
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              case WishListLoadingSuccessState:
                final successState = state as WishListLoadingSuccessState;
                return ListView.builder(
                    itemCount: successState.wishlistItems.length,
                    itemBuilder: (context, index) {
                      return WishlistTileWidget(
                        productsDataModel: successState.wishlistItems[index],
                        wishlistBloc: wishlistBloc,
                      );
                    });

              case WishListLoadingFailureState:
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
