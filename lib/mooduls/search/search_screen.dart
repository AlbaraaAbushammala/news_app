

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

// https://newsapi.org/v2/everything?q=tesla&apiKey=ecf35ab72c5d469cb6a299990465aaec
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener:(context, state) {} ,
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children:
            [
              defaultFormField(
                onChange:(value){
                  NewsCubit.get(context).getSearch(value);
                } ,
                controller: searchController,
                type: TextInputType.text,
                label: "Search",
                prefixIcon: Icons.search,
              ),
              Expanded(
                child: articleBuilder(
                  list,
                  context,
                  isSearch: true,
                ),
              ),
            ],
          ),
        ),
      );
        },
    );
  }
}
