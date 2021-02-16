//
//  HomeView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI
import Core
import Genre

struct HomeView: View {

//  @ObservedObject var presenter: HomePresenter
  @ObservedObject var presenter: GetListPresenter<Any, GenreModel, Interactor<Any,
  [GenreModel], GetGenresRepository<GetGenresLocaleDataSource, GetGenresRemoteDataSource, GenreTransformer>>>
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.list.isEmpty {
        emptyGenres
      } else {
        content
      }
    }.onAppear {
      if self.presenter.list.count == 0 {
        self.presenter.getList(request: nil)
      }
    }.navigationBarTitle(
      Text("Games Apps"),
      displayMode: .automatic
    ).navigationBarItems(trailing:
        NavigationLink(destination: ProfileView()) {
            Image(systemName: "person.crop.circle").imageScale(.large)
        }
    )
  }

}

extension HomeView {

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

  var emptyGenres: some View {
    CustomEmptyView(
      image: "assetNoFavorite",
      title: "The game genre is empty"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(
        self.presenter.list,
        id: \.id
      ) { genre in
        ZStack {
          self.linkBuilder(for: genre) {
            GenreRow(genre: genre)
          }.buttonStyle(PlainButtonStyle())
        }.padding(8)
      }
    }
  }
  
  func linkBuilder<Content: View>(
    for genre: GenreModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: HomeRouter().makeDetailView(for: genre)
    ) { content() }
  }

}
