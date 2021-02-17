//
//  ProfileView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import Game
import Core
import Genre

struct SearchView: View {
    @ObservedObject var presenter: SearchPresenter<GameModel,
  Interactor<String, [GameModel], SearchGamesRepository<GetSearchGamesLocaleDataSource, GetGamesRemoteDataSource,
  GamesTransformer<GameTransformer<GenreTransformer>>>>>
  
  var body: some View {
    VStack {
      SearchBar(
        text: $presenter.keyword,
        onSearchButtonClicked: presenter.search
      )
      
      ZStack {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.keyword.isEmpty {
          emptyTitle
        } else if presenter.list.isEmpty {
          emptyGames
        } else if presenter.isError {
          errorIndicator
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
                self.presenter.list,
                id: \.id
              ) { game in
                ZStack {
                  self.linkBuilder(for: game) {
                    SearchRow(game: game)
                  }.buttonStyle(PlainButtonStyle())
              }
            }
          }
        }
      }
      Spacer()
    }.navigationBarTitle(
      Text(LocalizedStringKey("search_game")),
      displayMode: .automatic
    )
    .navigationBarItems(trailing:
        NavigationLink(destination: ProfileView()) {
            Image(systemName: "person.crop.circle").imageScale(.large)
        }
    )
  }
}

extension SearchView {
  
  var loadingIndicator: some View {
    VStack {
      Text(LocalizedStringKey("loading"))
      ActivityIndicator()
    }
  }
  
  var errorIndicator: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: presenter.errorMessage
    ).offset(y: 80)
  }
  
  var emptyTitle: some View {
    CustomEmptyView(
      image: "assetSearchGame",
      title: "Come on, find your favorite game!"
    ).offset(y: 50)
  }
  var emptyGames: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: "Data not found"
    ).offset(y: 80)
  }
  
  func linkBuilder<Content: View>(
      for game: GameModel,
      @ViewBuilder content: () -> Content
  ) -> some View {
      
      NavigationLink(
          destination: DetailRouter().makeGameView(for: game)
      ) { content() }
  }
  
}
