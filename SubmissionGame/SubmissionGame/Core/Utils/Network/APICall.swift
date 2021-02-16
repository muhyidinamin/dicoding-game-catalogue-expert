//
//  APICall.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import Foundation

struct API {

  static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case genres
    case genre
    case games
    case game
    case search
    
    public var url: String {
      switch self {
      case .genres: return "\(API.baseUrl)genres"
      case .genre: return "\(API.baseUrl)genres/"
      case .games: return "\(API.baseUrl)games?genres="
      case .game: return "\(API.baseUrl)games/"
      case .search: return "\(API.baseUrl)games?search="
      }
    }
  }
  
}
