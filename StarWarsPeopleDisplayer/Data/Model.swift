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

struct PeopleDetails: Decodable {
    var name: String
    var description: String
    var gender: String
    var image: String
    var species: String
    var height: String
}
