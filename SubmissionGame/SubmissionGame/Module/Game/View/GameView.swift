//
//  GameView.swift
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

struct GameView: View {

  @State private var showingAlert = false
  
  @ObservedObject var presenter: GamePresenter<
      Interactor<String, GameModel, GetGameRepository<GetGamesLocaleDataSource,
  GetGameRemoteDataSource, GameTransformer<GenreTransformer>>>,
      Interactor<String, GameModel, UpdateFavoriteGameRepository<GetFavoriteGamesLocaleDataSource,
  GameTransformer<GenreTransformer>>>>
  
  var game: GameModel

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            imageGame
            menuButtonGame
            content
          }.padding()
        }
      }
    }.onAppear {
      self.presenter.getGame(request: String(self.game.id))
    }.alert(isPresented: $showingAlert) {
      Alert(
        title: Text("Oops!"),
        message: Text("Something wrong!"),
        dismissButton: .default(Text("OK"))
      )
    }.navigationBarTitle(
      Text(presenter.item?.title ?? ""),
      displayMode: .automatic
    )
  }

}

extension GameView {

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }

  var errorIndicator: some View {
    CustomEmptyView(
      image: "assetSearchNotFound",
      title: presenter.errorMessage
    ).offset(y: 80)
  }

  var menuButtonGame: some View {
    HStack(alignment: .center) {
      Spacer()
      if game.website != "Unknow" {
        CustomIcon(
          imageName: "link.circle",
          title: "Source"
        ).onTapGesture {
          self.openUrl(self.game.website)
        }
        Spacer()
      }
      if presenter.item?.favorite ?? false {
        CustomIcon(
          imageName: "heart.fill",
          title: "Favorited"
        ).onTapGesture { self.presenter.updateFavoriteGame(request: "\(self.game.id)") }
      } else {
        CustomIcon(
          imageName: "heart",
          title: "Favorite"
        ).onTapGesture { self.presenter.updateFavoriteGame(request: "\(self.game.id)") }
      }
      Spacer()
    }.padding()
  }

  var imageGame: some View {
    WebImage(url: URL(string: game.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
      .cornerRadius(30)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 8) {
      Group {
        table
        VStack(alignment: .leading) {
          Text("Description")
              .font(.headline)
          Text(game.desc)
              .font(.subheadline)
              .padding(.bottom)
        }
        .padding(.horizontal)
      }
    }.padding(.top)
  }
  
  var table: some View {
    HStack(alignment: .top, spacing: 20) {
        VStack(alignment: .leading) {
          VStack(alignment: .leading) {
            Text("Alternative Name")
              .font(.headline)
            ForEach(game.alternativeNames, id: \.self) { name in
                ZStack {
                  Text(name)
                    .font(.subheadline)
                }
            }
          }.padding(.bottom)
          VStack(alignment: .leading) {
            Text("Platforms")
              .font(.headline)
            ForEach(game.platforms, id: \.self) { platform in
                ZStack {
                  Text(platform)
                    .font(.subheadline)
                }
            }
          }.padding(.bottom)
          VStack(alignment: .leading) {
            Text("Genres")
              .font(.headline)
            ForEach(game.genres, id: \.id) { genre in
                ZStack {
                  Text(genre.title)
                    .font(.subheadline)
                }
            }
          }.padding(.bottom)
          VStack(alignment: .leading) {
            Text("Developers")
              .font(.headline)
            ForEach(game.developers, id: \.self) { developer in
                ZStack {
                  Text(developer)
                    .font(.subheadline)
                }
            }
          }.padding(.bottom)
          VStack(alignment: .leading) {
            Text("Website")
              .font(.headline)
            Text(game.website)
              .font(.subheadline)
          }
        }
        VStack(alignment: .leading) {
          VStack(alignment: .leading) {
            Text("Rating")
              .font(.headline)
            Text("\(game.rating, specifier: "%.2f")")
              .font(.subheadline)
          }.padding(.bottom)
          VStack(alignment: .leading) {
              Text("Metascore")
                .font(.headline)
              Text("\(game.metacritic)")
                .font(.subheadline)
          }.padding(.bottom)
          VStack(alignment: .leading) {
              Text("Release Date")
                .font(.headline)
              Text(game.released)
                .font(.subheadline)
          }.padding(.bottom)
          VStack(alignment: .leading) {
              Text("Publishers")
                .font(.headline)
              ForEach(game.publishers, id: \.self) { publisher in
                ZStack {
                  Text(publisher)
                    .font(.subheadline)
                }
              }
          }.padding(.bottom)
        }
      }.padding(.horizontal).frame(minHeight: 0, maxHeight: .infinity)
  }

}

extension GameView {

  func openUrl(_ linkUrl: String) {
    if let link = URL(string: linkUrl) {
      UIApplication.shared.open(link)
    } else {
      showingAlert = true
    }
  }

}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
  }
}
