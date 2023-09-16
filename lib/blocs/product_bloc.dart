//abstract class
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/models/result_product.dart';
import 'package:flutter_ecommerce_app/network/client.dart';
import 'package:flutter_ecommerce_app/network/dummy_repository.dart';

import '../constants/string.dart';

abstract class ProductState extends Equatable {
  final ResultProduct? data;
  final List<String>? categories;

  const ProductState({this.data, this.categories});
  @override
  List<Object?> get props => [data, categories];

  @override
  bool get stringify => true;
}

abstract class ProductEvent extends Equatable {}

//state
class InitialProduct extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingProduct extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadedProduct extends ProductState {
  final ResultProduct? data;
  final List<String>? categories;

  const LoadedProduct({this.data, this.categories});

  @override
  List<Object?> get props => [data, categories];
}

class LoadedCategories extends ProductState {
  final List<String> categories;

  const LoadedCategories({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class ErrorProduct extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FailedProduct extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//event
class SearchedAllProduct extends ProductEvent {
  final String? query;

  SearchedAllProduct({this.query = ""});

  @override
  List<Object?> get props => [query];
}

class SearchedProductId extends ProductEvent {
  final int id;

  SearchedProductId({required this.id});
  @override
  List<Object?> get props => [id];
}

class RetrievedCategories extends ProductEvent {
  final ResultProduct? data;

  RetrievedCategories({this.data});

  @override
  List<Object?> get props => [data];
}

class SearchedByCategory extends ProductEvent {
  final String category;

  SearchedByCategory({required this.category});
  @override
  List<Object?> get props => [category];
}

//bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  var dummyRepository = DummyRepository();
  var _category = <String>[];

  ProductBloc() : super(InitialProduct()) {
    on<SearchedAllProduct>(_onSearchedAllProduct);
    // on<RetrievedCategories>(_onRetrievedCategories);
    on<SearchedByCategory>(_onSearchByCategory);
    // on(_onSearchedByProductId);
  }

  _onSearchedAllProduct(
      SearchedAllProduct event, Emitter<ProductState> emit) async {
    emit(LoadingProduct());

    var dummyRepository = DummyRepository();

    var response;
    try {
      // search product by query
      if (event.query!.isNotEmpty) {
        response = await dummyRepository.findProductByQuery(event.query!);
        // log(response);
      } else {
        // search all products
        response = await dummyRepository.findAllProduct();
        // log(response);
      }

      var catResponse = await dummyRepository.findProductCategories();

      _category = List<String>.from(jsonDecode(catResponse)).toList();
      emit(LoadedProduct(
          data: ResultProduct.fromJson(
            jsonDecode(response),
          ),
          categories: _category));
    } catch (err) {
      log(err.toString());
      emit(ErrorProduct());
    }
  }

  _onSearchByCategory(
      SearchedByCategory event, Emitter<ProductState> emit) async {
    emit(LoadingProduct());

    try {
      var response =
          await dummyRepository.findProductByCategory(event.category);
      var json = jsonDecode(response);
      // log(response);
      // log("test=${state.categories}");

      emit(
        LoadedProduct(
            data: ResultProduct.fromJson(json), categories: _category),
      );
    } catch (err) {
      log(err.toString());
      emit(ErrorProduct());
    }
  }
}
