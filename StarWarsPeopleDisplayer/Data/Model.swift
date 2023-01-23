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
    var homeworld: String
    var gender: String
    var image: String
    var species: String
}

extension URLSession {
    func decode<T: Decodable>(
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate
    ) async throws  -> T {
        let (data, _) = try await data(from: url)

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy

        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
