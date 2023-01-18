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

struct People: Decodable {
    var name: String
    var gender: String
    
    enum CodingKeys: CodingKey {
        case name
        case gender
    }
}

struct LikablePerson {
    var personInfo: People
    var isLiked: Bool
}
