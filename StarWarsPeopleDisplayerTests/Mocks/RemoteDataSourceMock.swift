//
//  RemoteDataSourceMock.swift
//  StarWarsPeopleDisplayerTests
//
//  Created by Default on 1/19/23.
//
@testable import StarWarsPeopleDisplayer
import Foundation
import SwiftUI
import Combine

enum genericError: Error {
    case generic
}

class RemoteDataSourceMock: RemoteDataSourceProtocol {
    
    var shouldTestFail: Bool = false
    var peopleResponse: [People] = []
    
    func fetchStarWarsPeople() -> AnyPublisher<[StarWarsPeopleDisplayer.People], Error> {
        return Future<[People], Error> { promise in
            if self.shouldTestFail {
                promise(.failure(genericError.generic))
            } else {
                promise(.success(self.peopleResponse))
            }
        }.eraseToAnyPublisher()
    }
}


