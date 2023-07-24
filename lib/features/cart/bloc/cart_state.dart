part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadingSuccessState extends CartState {
  final List<ProductsDataModel> cartItems;
  CartLoadingSuccessState(this.cartItems);
}

class CartLoadingFailureState extends CartState {}

class CartRemovedActionState extends CartActionState {}
