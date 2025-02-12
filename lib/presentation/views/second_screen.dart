import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test2/core/utils/constants.dart';
import 'package:flutter_test2/domain/entities/item_movie.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_outlined)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(Constants.imageUrl + movie.poster_path,
                    width: double.infinity, height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Text(movie.title, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 10,
              ),
              Text(movie.overview),
            ],
          ),
        ));
  }
}
