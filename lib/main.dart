import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/mycart_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/observer_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:flutter_ecommerce_app/screens/app.dart';
import 'package:flutter_ecommerce_app/services/local_nofitication.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //add hydrated to persist data
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  //use to observe changes of state
  Bloc.observer = MyBlocObserver();

  //initialize local notification
  await LocalNotification.localNotification.setup();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) =>
            ProductBloc()..add(SearchedAllProduct()) //fetching all products
        ),
    BlocProvider(create: (context) => MyCartBloc()),
  ], child: const MyApp()));
}
