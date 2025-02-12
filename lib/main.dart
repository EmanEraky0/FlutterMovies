import 'package:flutter/material.dart';
import 'package:flutter_test2/data/repositories/auth_repo_impl.dart';
import 'package:flutter_test2/data/services/auth_service.dart';
import 'package:flutter_test2/presentation/viewModels/ItemViewModel.dart';
import 'package:flutter_test2/presentation/views/home_screen.dart';
import 'package:flutter_test2/presentation/views/second_screen.dart';
import 'package:provider/provider.dart';
import 'core/dependancy_injection.dart';
import 'domain/usecases/get_itemsUseCase.dart';

void main() async {
  setUpLocator();
  // await di.setUpLocator();

  final getItemsUseCase = GetItemsUseCase(authRepo:AuthRepoImpl(authService:  locator<AuthService>()));

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ItemViewModel(getItemsUseCase: getItemsUseCase)..callPopularMovies(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => SecondScreen(),
      },
    );
  }
}
