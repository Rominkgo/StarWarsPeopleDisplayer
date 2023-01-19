//
//  Model.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/17/23.
//

import Foundation

struct ApiResults: Decodable {
    var results: [People]
}

public struct People: Decodable {
    var name: String
    var gender: String
}

struct LikablePerson {
    var personInfo: People
    var isLiked: Bool
}
