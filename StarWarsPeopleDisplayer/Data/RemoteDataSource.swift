//
//  RemoteDataSource.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/17/23.
//

import Foundation
import Combine

class RemoteDataSource: ObservableObject {
    
    static let shared = RemoteDataSource()
    
    @Published var people: [People] = []
    @Published var hasError = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStarWarsPeople(_ url: String ) -> AnyPublisher<[People], Error> {
        
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
}



