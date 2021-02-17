//
//  DetailView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Game
import Core
import Genre

struct DetailView: View {
  @ObservedObject var presenter: GetListPresenter<String, GameModel,
  Interactor<String, [GameModel],
  GetGamesRepository<GetGamesLocaleDataSource,
  GetGamesRemoteDataSource, GamesTransformer<GameTransformer<GenreTransformer>>>>>
  
  var genre: GenreModel

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isLoading {
        errorIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            imageGenre
            spacer
            content
            spacer
          }.padding()
        }
      }
    }.onAppear {
//      self.presenter.getGenre()
      if self.presenter.list.count == 0 {
        self.presenter.getList(request: "\(self.genre.id)")
      }
    }.navigationBarTitle(Text(genre.title), displayMode: .large)
  }
}

extension DetailView {
  var spacer: some View {
    Spacer()
  }

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

  var imageGenre: some View {
    WebImage(url: URL(string: genre.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 250.0, height: 250.0, alignment: .center)
  }

  var gamesHorizontal: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(self.presenter.list, id: \.id) { game in
          ZStack {
            self.linkBuilder(for: game) {
              GameRow(game: game)
                .frame(width: 150, height: 150)
            }.buttonStyle(PlainButtonStyle())
          }
        }
      }
    }
  }

  var description: some View {
    Text(genre.desc)
      .font(.system(size: 15))
  }

  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      if !presenter.list.isEmpty {
        headerTitle("Games from \(genre.title)")
          .padding(.bottom)
        gamesHorizontal
      }
      spacer
      headerTitle("Description")
        .padding([.top, .bottom])
      description
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
