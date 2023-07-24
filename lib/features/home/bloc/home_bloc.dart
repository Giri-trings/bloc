import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_example/data/cart_items.dart';
import 'package:flutter_application_bloc_example/data/clothing_items.dart';
import 'package:flutter_application_bloc_example/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../../../models/product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishlistButtonNavigateEvent>(
        homeProductWishlistButtonNavigateEvent);
    on<HomeProductCartButtonNavigateEvent>(homeProductCartButtonNavigateEvent);
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('WishlistBitton Clicked');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductWishlsitedItemsState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('CartButton Clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductWishlsitedItemsState());
  }

  FutureOr<void> homeProductWishlistButtonNavigateEvent(
      HomeProductWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('wishlist Navigate');
    emit(HomeNavigateTowishlistPageActionState());
  }

  FutureOr<void> homeProductCartButtonNavigateEvent(
      HomeProductCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(
      HomeLoadingSuccessState(
        ClothingData.clothingProducts
            .map(
              (e) => ProductsDataModel(
                id: e['id'],
                name: e['name'],
                price: e['price'],
                imageUrl: e['imageUrl'],
                category: e['category'],
              ),
            )
            .toList(),
      ),
    );
  }
}
