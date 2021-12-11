import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/mooduls/business/business_screen.dart';
import 'package:news_app/mooduls/science/science_screen.dart';
import 'package:news_app/mooduls/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];


  void changeBottomNavBar (int index)
  {
    currentIndex = index;
    if(index == 1){
      getSports();
    } if(index == 2){
      getScience();
    }
    emit(NewsBottomNavState());
  }


  List<String> titles =
  [
    "Business Screen",
    "Sports Screen",
    "Science Screen",
  ];

  void changeAppbarTitles(int index)
  {
   currentIndex = index;
   emit(NewsAppbarTitlesState());

  }


  List<dynamic> business  = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());


        DioHelper.getData(
          url: "/v2/top-headlines",
          query: {
            'country': 'de',
            'category': 'business',
            'apikey': '8e0802a339a647c9bf97f05e4e79b51a',
          },
        ).then((value) {
          business = (value.data["articles"]);
          emit(NewsGetBusinessSuccessState());
        }).catchError((error) {
          print("thisss issss ==>  ${error.toString()}");
          emit(NewsGetBusinessErrorState(error.toString()));
        });

  }


  List<dynamic> sports  = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0 )
      {
        DioHelper.getData(
          url: "/v2/top-headlines",
          query: {
            'country': 'de',
            'category': 'sports',
            'apikey': '8e0802a339a647c9bf97f05e4e79b51a',
          },
        ).then((value) {

          sports = (value.data["articles"]);
          emit(NewsGetSportsSuccessState());
        }).catchError((error) {
          print("thisss issss ==>  ${error.toString()}");
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetSportsSuccessState());
        }

  }


  List<dynamic> science  = [];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0 )
      {
        DioHelper.getData(
          url: "/v2/top-headlines",
          query: {
            'country': 'de',
            'category': 'science',
            'apikey': '8e0802a339a647c9bf97f05e4e79b51a',
          },
        ).then((value) {

          science = (value.data["articles"]);

          emit(NewsGetScienceSuccessState());
        }).catchError((error) {
          print("thisss issss ==>  ${error.toString()}");
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }else
        {
          emit(NewsGetScienceSuccessState());
        }


  }


  List<dynamic> search  = [];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
      url: "v2/everything",
      query: {
        'q': '$value',
        'apikey': '8e0802a339a647c9bf97f05e4e79b51a',
      },
    ).then((value) {

      search = (value.data["articles"]);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print("thisss issss ==>  ${error.toString()}");
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }














}


