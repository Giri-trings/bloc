import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_example/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../../../models/product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }


  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) async {
    emit(WishListLoadingState());
    await Future.delayed(
      const Duration(seconds: 2),
    );
    emit(WishListLoadingSuccessState(wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.productsDataModel);
    emit(WishListLoadingSuccessState(wishlistItems));
  }
}
