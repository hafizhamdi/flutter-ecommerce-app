import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/result_product.dart';

class MyCartState extends Equatable {
  final List<Products> addedCarts;
  final List<Products> removedCarts;

  const MyCartState({
    this.addedCarts = const <Products>[],
    this.removedCarts = const <Products>[],
  });

  @override
  List<Object> get props => [addedCarts, removedCarts];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addedCarts': addedCarts.map((x) => x.toJson()).toList(),
      'removedCarts': removedCarts.map((x) => x.toJson()).toList(),
    };
  }

  factory MyCartState.fromMap(Map<String, dynamic> map) {
    return MyCartState(
      addedCarts: List<dynamic>.from((map['addedCarts']))
          .map((e) => Products.fromJson(e))
          .toList(),
      removedCarts: List<dynamic>.from((map['removedCarts']))
          .map((e) => Products.fromJson(e))
          .toList(),
    );
  }
}

abstract class MyCartEvent extends Equatable {
  const MyCartEvent();

  @override
  List<Object> get props => [];
}

class AddCart extends MyCartEvent {
  final Products cart;

  const AddCart({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];
}

class RemoveCart extends MyCartEvent {
  final int index;

  const RemoveCart({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class MyCartBloc extends HydratedBloc<MyCartEvent, MyCartState> {
  MyCartBloc() : super(const MyCartState()) {
    on<AddCart>(_onAddCart);
    on<RemoveCart>(_onRemoveCart);
  }

  FutureOr<void> _onAddCart(AddCart event, Emitter<MyCartState> emit) {
    final state = this.state;

    emit(MyCartState(addedCarts: List.from(state.addedCarts)..add(event.cart)));
  }
  FutureOr<void> _onRemoveCart(RemoveCart event, Emitter<MyCartState> emit) {
    final state = this.state;

    emit(MyCartState(addedCarts: List.from(state.addedCarts)..removeAt(event.index)));
  }

  @override
  MyCartState? fromJson(Map<String, dynamic> json) {
    return MyCartState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(MyCartState state) {
    return state.toMap();
  }
}
