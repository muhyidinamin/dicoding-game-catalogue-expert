//
//  FavoriteRow.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game
import Genre

struct FavoriteRow: View {

  var game: GameModel

  var body: some View {
    VStack {
      imageGenre
      content
      Spacer()
      Divider()
        .padding(.leading)
    }
  }

}

extension FavoriteRow {

  var imageGenre: some View {
    ZStack(alignment: .center) {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
    
        WebImage(url: URL(string: game.image))
          .resizable()
          .indicator(.activity)
          .transition(.fade(duration: 0.5))
          .scaledToFit()
    }
    .aspectRatio(16/9, contentMode: .fit)
    .cornerRadius(8)
    .shadow(radius: 4)
  }

  var content: some View {
    HStack {
      VStack(alignment: .leading, spacing: 5) {
          platforms
          Text(game.title)
              .font(.title)
              .fontWeight(.black)
          HStack {
              Text(LocalizedStringKey("release"))
                  .font(.headline)
              Text(getReleaseDate(released: game.released))
                  .font(.subheadline)
                  .padding(.trailing)
              Text(LocalizedStringKey("rating"))
                  .font(.headline)
              Text("\(game.rating, specifier: "%.2f")")
                  .font(.subheadline)
          }
          HStack {
              Text(LocalizedStringKey("genre"))
                  .font(.headline)
              HStack {
                Text(genreText(genres: game.genres))
                  .font(.subheadline)
          }
        }
      }.padding()
      Spacer()
    }
  }
  
  var platforms : some View {
    HStack {
      ForEach(game.parentPlatforms, id: \.self) { slug in
        Group {
          PlatformIcon(platform: slug)
        }
      }
    }
  }
  
  func getReleaseDate(released: String) -> String {
    return Date().releaseDateToString(releaseDate: released )
  }

  func genreText(genres: [GenreModel]) -> String {
    var genre: String = ""
    if genres.count != 0 {
      for (i, item) in genres.enumerated() {
        if i != genres.endIndex - 1 {
          genre += "\(item.title), "
        } else {
          genre += "\(item.title)"
        }
      }
    }
    return genre
  }
}
