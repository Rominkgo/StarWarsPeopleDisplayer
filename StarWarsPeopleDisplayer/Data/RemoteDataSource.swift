//
//  RemoteDataSource.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/17/23.
//

import Foundation
import Combine

class RemoteDataSource: ObservableObject, RemoteDataSourceProtocol {
    
    var remoteprotocol: RemoteDataSourceProtocol?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStarWarsPeople() -> AnyPublisher<[People], Error> {
        let url = "https://swapi.dev/api/people"
        let urlString: URL = URL(string: url)!
    
        return URLSession.shared
            .dataTaskPublisher(for: urlString)
            .receive(on: DispatchQueue.main)
            .tryMap({ data, reponse in
                let decoder = JSONDecoder()
                guard let people = try? decoder.decode(ApiResults.self, from: data) else {
                    throw fatalError("No data")
                }
                return people.results
            }).eraseToAnyPublisher()
    }
    
    func fetchStarWarsPeopleDetails() -> AnyPublisher<[PeopleDetails], Error> {
//        let url = "https://akabab.github.io/starwars-api/api/all.json"
      let url = "https://swapi.dev/api/people"
        let urlString: URL = URL(string: url)!
    
        return URLSession.shared
            .dataTaskPublisher(for: urlString)
            .receive(on: DispatchQueue.main)
            .tryMap({ data, reponse in
                let decoder = JSONDecoder()
                guard let people = try? decoder.decode([PeopleDetails].self, from: data) else {
                    throw fatalError("No data")
                }
                print(people)
                return people
            }).eraseToAnyPublisher()
    }
}

protocol RemoteDataSourceProtocol {
    func fetchStarWarsPeople() -> AnyPublisher<[People], Error>
    func fetchStarWarsPeopleDetails() -> AnyPublisher<[PeopleDetails], Error>
}



