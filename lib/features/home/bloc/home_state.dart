part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingSuccessState extends HomeState {
  final List<ProductsDataModel> products;

  HomeLoadingSuccessState(this.products);
}

class HomeLoadingFailureState extends HomeState {}

class HomeNavigateTowishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}


class HomeProductWishlsitedItemsState extends HomeActionState{}
class HomeProductCartedItemsState extends HomeActionState{}
