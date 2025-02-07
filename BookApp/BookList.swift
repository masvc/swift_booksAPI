struct BookList: Decodable {
  let items: [Book]
}

struct Book: Decodable {
  let id: String
  let volumeInfo: VolumeInfo // 入れ子になっているので別に型を定義
}

struct VolumeInfo: Decodable {
  let title: String
  let description: String? // データによってはnilが返ってくるのでオプショナル
}
