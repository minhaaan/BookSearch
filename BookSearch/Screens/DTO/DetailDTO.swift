//
//  DetailDTO.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

struct DetailDTO: Codable {
  let error: String
  let title: String
  let subtitle: String
  let authors: String
  let publisher: String
  let language: String
  let isbn10: String
  let isbn13: String
  let pages: String
  let year: String
  let rating: String
  let desc: String
  let price: String
  let image: String
  let url: String
  let pdf: [String: String]?
}
