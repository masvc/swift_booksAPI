//
//  BookAppApp.swift
//  BookApp
//
//  Created by masato yoshida on 2025/02/07.
//

import SwiftUI

@main
struct BookApp: App {
  var body: some Scene {
    WindowGroup {
      TabView {
        // "Books" タブ
        Tab("Books",systemImage: "books.vertical") {
          ContentView() // ここに表示したいビューを指定
        }
        
        // "Favorites" タブ
        Tab("Favorite", systemImage:"star") {
          Text("Favoritesは未実装") // ここに表示したいビューを指定
        }
        
        Tab("test", systemImage:"star") {
          Text("test") // ここに表示したいビューを指定
        }
        
        Tab("test2", systemImage:"star") {
          Text("test2") // ここに表示したいビューを指定
        }
        
        Tab("test3", systemImage:"star") {
          Text("test3") // ここに表示したいビューを指定
        }
        
      }
    }
  }
}

