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
}

abstract class ProductEvent {}

//state
class InitialProduct extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
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
  List<Object?> get props => [data];
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
}

class SearchedProductId extends ProductEvent {
  final int id;

  SearchedProductId({required this.id});
}

class RetrievedCategories extends ProductEvent {}

//bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitialProduct()) {
    on<SearchedAllProduct>(_onSearchedAllProduct);
    on<RetrievedCategories>(_onRetrievedCategories);
    // on(_onSearchedByProductId);
  }

  _onSearchedAllProduct(
      SearchedAllProduct event, Emitter<ProductState> emit) async {
    emit(LoadingProduct());

    var client = NetworkClient(baseUrl: DUMMY_BASE_URL);
    var dummyRepository = DummyRepository(client: client);

    var response;
    try {
      // search product by query
      if (event.query!.isNotEmpty) {
        response = await dummyRepository.findProductByQuery(event.query!);
        log(response);
      } else {
        // search all products
        response = await dummyRepository.findAllProduct();
        log(response);
      }
      emit(
        LoadedProduct(
          data: ResultProduct.fromJson(jsonDecode(response)),
        ),
      );
    } catch (err) {
      log(err.toString());
      emit(ErrorProduct());
    }
  }

  _onRetrievedCategories(
      RetrievedCategories event, Emitter<ProductState> emit) async {
    emit(LoadingProduct());

    var client = NetworkClient(baseUrl: DUMMY_BASE_URL);
    var dummyRepository = DummyRepository(client: client);

    try {
      var response = await dummyRepository.findProductCategories();
      var json = jsonDecode(response);
      log(response);

      emit(
        LoadedProduct(
            data: state.data, categories: List<String>.from(json).toList()),
      );
    } catch (err) {
      log(err.toString());
      emit(ErrorProduct());
    }
  }

  // _onSearchedByProductId(
  //     SearchedProductId event, Emitter<ProductState> emit) async {
  //   emit(LoadingProduct());
  //   try {
  //     var response = dummyRepository.findProductById(event.id);

  //     emit(LoadedProduct(data: Products.fromJson(response)));
  //   } catch (err) {
  //     emit(ErrorProduct());
  //   }
  // }
}
