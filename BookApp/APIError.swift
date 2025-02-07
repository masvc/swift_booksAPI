enum APIError: Error {
  case invalidURL, failedToFetch(statusCode: Int), decodeError
}
