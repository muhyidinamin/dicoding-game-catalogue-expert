//
//  HomeRouter.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import Genre
import Core
import Game

class HomeRouter {

  func makeDetailView(for genre: GenreModel) -> some View {
    let useCase: Interactor<
        String,
        [GameModel],
        GetGamesRepository<
            GetGamesLocaleDataSource,
            GetGamesRemoteDataSource,
            GamesTransformer<GameTransformer<GenreTransformer>>>
    > = Injection.init().provideGames()
    
    let presenter = GetListPresenter(useCase: useCase)
    
    return DetailView(presenter: presenter, genre: genre)
  }
  
}
