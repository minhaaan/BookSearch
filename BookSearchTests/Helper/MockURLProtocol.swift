//
//  MockURLProtocol.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

import Foundation

public class MockURLProtocol: URLProtocol {

  public override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  public static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

  public override func startLoading() {
    guard let handler = MockURLProtocol.requestHandler else {
      fatalError()
    }

    do {
      let (res, data) = try handler(request)

      client?.urlProtocol(self, didReceive: res, cacheStoragePolicy: .notAllowed)

      if let data {
        client?.urlProtocol(self, didLoad: data)
      }

      client?.urlProtocolDidFinishLoading(self)
    } catch {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }

  public override func stopLoading() {

  }

}
