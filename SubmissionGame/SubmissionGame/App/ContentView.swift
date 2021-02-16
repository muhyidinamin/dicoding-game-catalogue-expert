//
//  ContentView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 23/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import Core
import Genre
import Game

struct ContentView: View {
  let homePresenter: GetListPresenter<Any, GenreModel,
    Interactor<Any, [GenreModel],
  GetGenresRepository<GetGenresLocaleDataSource,
  GetGenresRemoteDataSource, GenreTransformer>>>
  let favoritePresenter: GetListPresenter<String, GameModel,
    Interactor<String, [GameModel],
  GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource, GamesTransformer<GameTransformer<GenreTransformer>>>>>
  let searchPresenter: SearchPresenter<GameModel,
    Interactor<String, [GameModel],
  SearchGamesRepository<GetSearchGamesLocaleDataSource, GetGamesRemoteDataSource,
  GamesTransformer<GameTransformer<GenreTransformer>>>>>

  var body: some View {
    TabView {
      NavigationView {
        HomeView(presenter: homePresenter)
      }.tabItem {
        TabItem(imageName: "house", title: "Home")
      }

      NavigationView {
        SearchView(presenter: searchPresenter)
      }.tabItem {
        TabItem(imageName: "magnifyingglass", title: "Search")
      }

      NavigationView {
        FavoriteView(presenter: favoritePresenter)
      }.tabItem {
        TabItem(imageName: "heart", title: "Favorite")
      }
    }
  }
}
