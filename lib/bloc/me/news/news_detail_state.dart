part of 'news_detail_bloc.dart';

abstract class NewsDetailState extends Equatable {
  const NewsDetailState();
}

class NewsDetailInitial extends NewsDetailState {
  @override
  List<Object> get props => [];
}
