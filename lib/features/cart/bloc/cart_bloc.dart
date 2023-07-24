import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc_example/data/cart_items.dart';
import 'package:meta/meta.dart';

import '../../../models/product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(CartLoadingSuccessState(cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productsDataModel);
    emit(CartLoadingSuccessState(cartItems));
    emit(CartRemovedActionState());
  }
}
