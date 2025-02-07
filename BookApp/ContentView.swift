//
//  ContentView.swift
//  BookApp
//
//  Created by masato yoshida on 2025/02/07.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      // システムの「地球」アイコンを表示
      Image(systemName: "globe")
        .imageScale(.large) // アイコンのサイズを大きくする
        .foregroundStyle(.tint) // アイコンの色をシステムのティントカラーに設定
      // 「Hello, world!」というテキストを表示
      Text("Hello, world!")
    }
    .padding() // VStack全体にパディングを追加
  }

  // 本のデータを非同期で取得する関数
  func fetchBooks() async throws -> [Book] {
    // Google Books APIのURLを文字列として定義
    let urlString = "https://www.googleapis.com/books/v1/volumes?q=quilting"
    // URL文字列をURL型に変換し、失敗した場合はエラーをスロー
    guard let url = URL(string: urlString) else { // ①
      throw APIError.invalidURL
    }
    // URLリクエストを作成し、HTTPメソッドをGETに設定
    var request = URLRequest(url: url) // ②
    request.httpMethod = "GET"
    // URLSessionを使ってデータを非同期で取得
    let (data, response) = try await URLSession.shared.data(for: request) // ③

    // HTTPレスポンスのステータスコードをチェックし、エラーの場合はスロー
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw APIError.failedToFetch(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
    } // ④

    do {
      // 取得したデータをBookList型にデコード
      let bookList = try JSONDecoder().decode(BookList.self, from: data)
      return bookList.items // 本のリストを返す
    } catch {
      // デコードに失敗した場合はエラーをスロー
      throw APIError.decodeError
    }
  }

}

#Preview {
  ContentView()
}
