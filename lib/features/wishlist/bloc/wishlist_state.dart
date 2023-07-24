part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishListLoadingState extends WishlistState {}

class WishListLoadingSuccessState extends WishlistState {
  final List<ProductsDataModel> wishlistItems;
  WishListLoadingSuccessState(this.wishlistItems);
}

class WishListLoadingFailureState extends WishlistState {}

class WishListRemovedActionState extends WishlistState {}
