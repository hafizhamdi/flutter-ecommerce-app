//abstract class
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/models/result_product.dart';
import 'package:flutter_ecommerce_app/network/client.dart';
import 'package:flutter_ecommerce_app/network/dummy_repository.dart';

import '../constants/string.dart';

abstract class ProductState {}

abstract class ProductEvent {}

//state
class InitialProduct extends ProductState {}

class LoadingProduct extends ProductState {}

class LoadedProduct extends ProductState {
  final ResultProduct data;

  LoadedProduct({required this.data});
}

class ErrorProduct extends ProductState {}

class FailedProduct extends ProductState {}

//event
class FetchedAllProduct extends ProductEvent {}

class FetchedProductId extends ProductEvent {
  final int id;

  FetchedProductId({required this.id});
}

//bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitialProduct()) {
    on(_onFetchedAllProduct);
    // on(_onFetchedByProductId);
  }

  _onFetchedAllProduct(
      FetchedAllProduct event, Emitter<ProductState> emit) async {
    emit(LoadingProduct());

    var client = NetworkClient(baseUrl: DUMMY_BASE_URL);
    var dummyRepository = DummyRepository(client: client);

    try {
      var response = await dummyRepository.findAllProduct();
      log(response);

      emit(
        LoadedProduct(
          data: ResultProduct.fromJson(jsonDecode(response)),
        ),
      );
    } catch (err) {
      print(err);
      log(err.toString());
      emit(ErrorProduct());
    }
  }

  // _onFetchedByProductId(
  //     FetchedProductId event, Emitter<ProductState> emit) async {
  //   emit(LoadingProduct());
  //   try {
  //     var response = dummyRepository.findProductById(event.id);

  //     emit(LoadedProduct(data: Products.fromJson(response)));
  //   } catch (err) {
  //     emit(ErrorProduct());
  //   }
  // }
}
