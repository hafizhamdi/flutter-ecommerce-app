import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:flutter_ecommerce_app/screens/myapp.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ProductBloc()
        ..add(SearchedAllProduct()) //fetching all products
        ..add(RetrievedCategories()), //fetching all categories available
    ),
  ], child: MyApp()));
}
