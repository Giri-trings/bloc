import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_example/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_bloc_example/features/cart/ui/cart_screen.dart';
import 'package:flutter_application_bloc_example/features/home/ui/product_tile_widget.dart';
import 'package:flutter_application_bloc_example/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_application_bloc_example/features/wishlist/ui/wishlist_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateTowishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        } else if (state is HomeProductWishlsitedItemsState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('item successfully added into Wishlist')));
        } else if (state is HomeProductCartedItemsState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('item successfully added into Cartlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: const Text('Shoppie'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      homeBloc.add(HomeProductWishlistButtonNavigateEvent());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonNavigateEvent());
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      homeBloc: homeBloc,
                      productsDataModel: successState.products[index],
                      wishlistBloc: wishlistBloc,
                    );
                  }),
            );

          case HomeLoadingFailureState:
            return const Scaffold(
              body: Center(child: Text('Error')),
            );

          default:
            return const SizedBox();
        }

        //
      },
    );
  }
}
