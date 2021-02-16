//
//  DetailRouter.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import Game
import Genre
import Core

class DetailRouter {

  func makeGameView(for game: GameModel) -> some View {
    let useCase: Interactor<
        String,
        GameModel,
        GetGameRepository<
            GetGamesLocaleDataSource,
            GetGameRemoteDataSource,
            GameTransformer<GenreTransformer>>
    > = Injection.init().provideGame()
    
    let favoriteUseCase: Interactor<
        String,
        GameModel,
        UpdateFavoriteGameRepository<
            GetFavoriteGamesLocaleDataSource,
            GameTransformer<GenreTransformer>>
    > = Injection.init().provideUpdateFavorite()
    
    let presenter = GamePresenter(gameUseCase: useCase, favoriteUseCase: favoriteUseCase)
    
    return GameView(presenter: presenter, game: game)
  }

}
