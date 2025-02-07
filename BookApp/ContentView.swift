//
//  ContentView.swift
//  BookApp
//
//  Created by masato yoshida on 2025/02/07.
//

import SwiftUI

// ContentViewはアプリのメインビューを表します
struct ContentView: View {
  // booksはBook型の配列で、@Stateを使ってビューの状態として管理します
  @State var books = [Book]() // ここにレスポンスを入れ込む
  @State var isLoading: Bool = false // データ取得中かどうかを示すフラグ
  
  // bodyはビューのレイアウトを定義します
  var body: some View {
    // NavigationStackは画面遷移を管理するためのコンテナです
    NavigationStack {
      ZStack {
        // Listは本のリストを表示します
        List(books, id: \.id) { book in
          // NavigationLinkはタップしたときに別のビューに遷移します
          NavigationLink {
            // 遷移先のビューとして本の説明を表示します
            Text(book.volumeInfo.description ?? "No description") // 遷移先
              .padding() // テキストの周りに余白を追加
          } label: {
            // リストに表示される本のタイトル
            Text(book.volumeInfo.title) // Listに表示される
          }
        }
        // isLoadingがtrueの場合、ProgressViewを表示
        if isLoading {
          ProgressView() // データ取得中のインジケーター
        }
      }
      .navigationTitle("本一覧") // タイトル
      .navigationBarTitleDisplayMode(.inline) // 小さく表示
    }
    // .taskは非同期タスクを実行するために使用します
    .task {
      do {
        // fetchBooks関数を呼び出して本のデータを取得します
        isLoading = true // データ取得開始
        books = try await fetchBooks() // 本のデータを取得
        isLoading = false // データ取得完了
      } catch {
        // エラーが発生した場合はエラーメッセージをコンソールに表示します
        print(error.localizedDescription) // エラーメッセージを表示
      }
    }
  }
  
  // 本のデータを非同期で取得する関数
  func fetchBooks() async throws -> [Book] {
    // Google Books APIのURLを文字列として定義
    let urlString = "https://www.googleapis.com/books/v1/volumes?q=swift"
    // URL文字列をURL型に変換し、失敗した場合はエラーをスロー
    guard let url = URL(string: urlString) else {
      throw APIError.invalidURL // URLが無効な場合のエラー
    }
    // URLリクエストを作成し、HTTPメソッドをGETに設定
    var request = URLRequest(url: url)
    request.httpMethod = "GET" // HTTPメソッドをGETに設定
    // URLSessionを使ってデータを非同期で取得
    let (data, response) = try await URLSession.shared.data(for: request)
    
    // HTTPレスポンスのステータスコードをチェックし、エラーの場合はスロー
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw APIError.failedToFetch(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1) // ステータスコードがエラーの場合
    }
    
    do {
      // 取得したデータをBookList型にデコード
      let bookList = try JSONDecoder().decode(BookList.self, from: data)
      // デコードに成功した場合は本のリストを返します
      return bookList.items // 本のリストを返す
    } catch {
      // デコードに失敗した場合はエラーをスロー
      throw APIError.decodeError // デコードエラー
    }
  }
}

// プレビュー用のコード
#Preview {
  ContentView() // ContentViewのプレビューを表示
}
