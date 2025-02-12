import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test2/core/utils/constants.dart';
import 'package:flutter_test2/domain/entities/item_movie.dart';
import 'package:provider/provider.dart';

import '../../core/utils/state_screen.dart';
import '../viewModels/ItemViewModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ItemViewModel>(context);
    final ScrollController _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        viewModel.callPopularMovies(); // Trigger "load more" in the ViewModel
      }
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notification_add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
        title: Text('Movies Screen'),
      ),
      body: Builder(builder: (_) {
        switch (viewModel.state) {
          case StateScreen.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case StateScreen.error:
            return Center(
              child: Text(
                viewModel.errorMsg,
                style: TextStyle(color: Colors.red),
              ),
            );
          case StateScreen.loaded:
            return Expanded(
                child: GridView.builder(
                  controller:_scrollController ,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 1.0, // Space between columns
                mainAxisSpacing: 1.0, // Space between rows
                childAspectRatio: 3 / 4, // Aspect ratio of each grid item
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: viewModel.allMovies.results.length,
              // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                final item = viewModel.allMovies.results[index];
                return SizedBox(
                  height: 200, // Constrain item height
                  child: itemMovies(item,context),
                );
              },
            ));
          default:
            return Text("not found state");
        }
      }),
    );
  }

  Widget itemMovies(Movie movie , BuildContext context){
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/details',arguments:movie);
        },
        child: Card(
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  Constants.imageUrl + movie.poster_path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ]),
              )
            ],
          ),
        ));
  }
}
