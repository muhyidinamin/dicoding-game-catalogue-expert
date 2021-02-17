//
//  FavoriteView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import Game
import Genre
import Core

struct FavoriteView: View {

    @ObservedObject var presenter: GetListPresenter<String, GameModel,
  Interactor<String, [GameModel],
  GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource,
  GamesTransformer<GameTransformer<GenreTransformer>>>>>

  var body: some View {
    ZStack {

      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.list.count == 0 {
        emptyFavorites
      } else {
        content
      }
    }.onAppear {
      self.presenter.getList(request: nil)
    }.navigationBarTitle(
      Text(LocalizedStringKey("favorite_game")),
      displayMode: .automatic
    )
    .navigationBarItems(trailing:
        NavigationLink(destination: ProfileView()) {
            Image(systemName: "person.crop.circle").imageScale(.large)
        }
    )
  }

}

extension FavoriteView {
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

  var emptyFavorites: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: "Your favorite is empty"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(
      .vertical,
      showsIndicators: false
    ) {
      ForEach(
        self.presenter.list,
        id: \.id
      ) { game in
        ZStack {
          self.linkBuilder(for: game) {
            FavoriteRow(game: game)
          }.buttonStyle(PlainButtonStyle())
        }

      }
    }
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
