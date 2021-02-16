//
//  HomeRow.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Genre

struct GenreRow: View {

  var genre: GenreModel
  var body: some View {
    VStack {
      imageGenre
      content
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 250)
    .background(Color.random.opacity(0.3))
    .cornerRadius(30)
  }

}

extension GenreRow {

  var imageGenre: some View {
    WebImage(url: URL(string: genre.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 300)
      .cornerRadius(30)
      .padding(.top)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(genre.title)
        .font(.title)
        .bold()
      
      Text("Game Count : \(genre.gamesCount)")
        .font(.system(size: 14))
        .lineLimit(2)
    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }
}

//struct GenreRow_Previews: PreviewProvider {
//
//  static var previews: some View {
//    let game = GenreDomainModel(
//      id: 1,
//      title: "Action",
//      image: "https://media.rawg.io/media/games/7fa/7fa0b586293c5861ee32490e953a4996.jpg",
//      gamesCount: 111,
//      desc: "adasdada"
//    )
//    return GenreRow(genre: game)
//  }
//
//}
