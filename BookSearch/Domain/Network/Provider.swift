//
//  Provider.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

protocol ProviderType: AnyObject {
  associatedtype Target: TargetType

  func request<T: Decodable>(_ target: Target) async throws -> T
}

class Provider<Target: TargetType>: ProviderType {
  let session: URLSession

  init(session: URLSession) {
    self.session = session
  }

  func request<T: Decodable>(
    _ target: Target
  ) async throws -> T {
    // URL 생성
    guard let url = URL(
      string: target.baseURL + target.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
    ) else {
      throw URLError(.badURL)
    }

    // URLRequest 생성1
    var request = URLRequest(url: url.absoluteURL)
    request.httpMethod = "GET" // GET만 사용한다

    // 데이터 요청
    let (data, response) = try await session.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }

    return try JSONDecoder().decode(T.self, from: data)
  }

}
