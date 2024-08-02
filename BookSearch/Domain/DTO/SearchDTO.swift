//
//  SearchDTO.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

struct SearchDTO: Codable {
  let error: String
  let total: String
  let page: String
  let books: [Book]

  struct Book: Codable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
  }
}
