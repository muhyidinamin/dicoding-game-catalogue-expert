//
//  Injection.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import UIKit
import Core
import Genre
import Game

final class Injection: NSObject {
  func provideGenre<U: UseCase>() -> U where U.Request == Any, U.Response == [GenreModel] {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let locale = GetGenresLocaleDataSource(realm: appDelegate.realm)
      let remote = GetGenresRemoteDataSource(endpoint: Endpoints.Gets.genres.url)
      let mapper = GenreTransformer()
      let repository = GetGenresRepository(
          localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)
      return Interactor(repository: repository) as! U
  }
  
  func provideGames<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      
      let locale = GetGamesLocaleDataSource(realm: appDelegate.realm)
      
      let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)
    
      let genreMapper = GenreTransformer()
      let gameMapper = GameTransformer(genreMapper: genreMapper)
      let mapper = GamesTransformer(gameMapper: gameMapper)
      
      let repository = GetGamesRepository(
          localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)
      
      return Interactor(repository: repository) as! U
  }
  
  func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetSearchGamesLocaleDataSource(realm: appDelegate.realm)
      let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.search.url)

      let genreMapper = GenreTransformer()
      let gameMapper = GameTransformer(genreMapper: genreMapper)
      let mapper = GamesTransformer(gameMapper: gameMapper)

      let repository = SearchGamesRepository(
        localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)

      return Interactor(repository: repository) as! U
  }

  func provideGame<U: UseCase>() -> U where U.Request == String, U.Response == GameModel {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate

      let locale = GetGamesLocaleDataSource(realm: appDelegate.realm)

      let remote = GetGameRemoteDataSource(endpoint: Endpoints.Gets.game.url)

      let genreMapper = GenreTransformer()
      let mapper = GameTransformer(genreMapper: genreMapper)

      let repository = GetGameRepository(
          localeDataSource: locale,
          remoteDataSource: remote,
          mapper: mapper)

      return Interactor(repository: repository) as! U
  }

  func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == GameModel {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate

      let locale = GetFavoriteGamesLocaleDataSource(realm: appDelegate.realm)

      let genreMapper = GenreTransformer()
      let mapper = GameTransformer(genreMapper: genreMapper)

      let repository = UpdateFavoriteGameRepository(
          localeDataSource: locale,
          mapper: mapper)

      return Interactor(repository: repository) as! U
  }

  func provideFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate

      let locale = GetFavoriteGamesLocaleDataSource(realm: appDelegate.realm)

      let genreMapper = GenreTransformer()
      let gameMapper = GameTransformer(genreMapper: genreMapper)
      let mapper = GamesTransformer(gameMapper: gameMapper)

      let repository = GetFavoriteGamesRepository(
          localeDataSource: locale,
          mapper: mapper)

      return Interactor(repository: repository) as! U
  }

}
