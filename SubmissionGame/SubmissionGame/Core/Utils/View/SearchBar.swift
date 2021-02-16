//
//  SearchView.swift
//  SubmissionGame
//
//  Created by Muhamad Muhyidin Amin on 24/01/21.
//  Copyright © 2021 Amint Dev Labs. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

  @Binding var text: String
  var onSearchButtonClicked: (() -> Void)?

  class Coordinator: NSObject, UISearchBarDelegate {

    let control: SearchBar

    init(_ control: SearchBar) {
      self.control = control
    }

    func searchBar(
      _ searchBar: UISearchBar,
      textDidChange searchText: String
    ) {
      control.text = searchText
    }

    func searchBarSearchButtonClicked(
      _ searchBar: UISearchBar
    ) {
      control.onSearchButtonClicked?()
    }
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }

  func makeUIView(
    context: UIViewRepresentableContext<SearchBar>
  ) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    return searchBar
  }

  func updateUIView(
    _ uiView: UISearchBar,
    context: UIViewRepresentableContext<SearchBar>
  ) {
    uiView.text = text
  }

}
