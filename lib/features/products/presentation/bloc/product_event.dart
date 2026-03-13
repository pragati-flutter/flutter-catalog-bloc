part of 'product_bloc.dart';
abstract class ProductEvent extends Equatable{

}

class GetProductEvent extends ProductEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class GetProductDetailEvent extends ProductEvent{
  final int id;
  GetProductDetailEvent(this.id);

  @override
  List<Object?> get props => [id];

}


class SearchProductEvent extends ProductEvent{
  final String query;
 SearchProductEvent(this.query);

  @override
  List<Object?> get props => [query];

}