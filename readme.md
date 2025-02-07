# BookApp

BookApp は、SwiftUI を使用して構築されたシンプルな iOS アプリケーションです。このアプリは Google Books API を利用して、Swift に関連する書籍のリストを表示します。

## 機能

- **書籍一覧表示**: Swift に関連する書籍のリストを表示します。
- **書籍詳細表示**: 各書籍をタップすると、その書籍の詳細情報を表示します。
- **タブビュー**: 複数のタブを持ち、現在は「Books」と「Favorites」タブが実装されています。

## 使用技術

- **SwiftUI**: ユーザーインターフェースの構築に使用。
- **Google Books API**: 書籍データの取得に使用。
- **非同期処理**: `async/await`を使用してデータを非同期に取得。

## ファイル構成

- `BookAppApp.swift`: アプリのエントリーポイント。
- `ContentView.swift`: メインのビューを定義。
- `BookList.swift`: 書籍データのモデルを定義。
- `APIError.swift`: API エラーを定義。

## セットアップ

1. このリポジトリをクローンします。
2. Xcode でプロジェクトを開きます。
3. シミュレーターまたは実機でアプリをビルドして実行します。

## 注意事項

- Google Books API の利用にはインターネット接続が必要です。
- 現在、「Favorites」タブは未実装です。

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。
