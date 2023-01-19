//
//  ContentViewModel.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/17/23.
//

import Foundation
import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    
    private let datasource: RemoteDataSourceProtocol
    
    init(datasource: RemoteDataSourceProtocol) {
        self.datasource = datasource
        self.likedPersonExists = UserDefaults.standard.bool(forKey: "likedPersonExists")
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var people: [LikablePerson] = []
    @Published var errorHandler: String = ""
    
    var likedPersonExists: Bool = false {
        didSet {
            UserDefaults.standard.set(likedPersonExists, forKey: "likedPersonExists")
        }
    }

    func getPeopleData() {
        datasource.fetchStarWarsPeople()
            .sink(receiveCompletion: {response in
                switch response {
                case .finished:
                    print("Call finish")
                case .failure(_):
                    self.errorHandler = "There was an error with the api"
                }
            }, receiveValue: { [weak self] res in
                let likeablePeople = res.map { person in
                   LikablePerson(personInfo: person, isLiked: false)
                }
                self?.people = likeablePeople
                self?.checkForLikedPerson()
            })
            .store(in: &cancellables )
    }
    
    func findIndex(of person: LikablePerson) -> Int {
        
        let likedIndex = people.firstIndex { candidate in
            candidate.personInfo.name == person.personInfo.name
        }
        guard let safeIndex = likedIndex else {
            return 0
        }
        
        return safeIndex
    }
    
    func markPersonLiked(_ person: LikablePerson) {
        
        let safeIndex = findIndex(of: person)

        if people.count >= safeIndex, likedPersonExists == false
        {
            print(person.personInfo.name + " Loved")
            people[safeIndex] = LikablePerson(personInfo: person.personInfo, isLiked: true)
            likedPersonExists = true
            UserDefaults.standard.set(person.personInfo.name, forKey: "FavouritePerson")
        }
    }
    
    func markPersonUnliked(_ person: LikablePerson) {
        let safeIndex = findIndex(of: person)
        
        if people.count >= safeIndex {
            print(person.personInfo.name + " UNLoved")
            people[safeIndex] = LikablePerson(personInfo: person.personInfo, isLiked: false)
            likedPersonExists = false
            UserDefaults.standard.removeObject(forKey: "FavouritePerson")
        }
    }
    
    func checkForLikedPerson() {
        let savedPerson = UserDefaults.standard.string(forKey: "FavouritePerson")
        
        let likedIndex = people.firstIndex { candidate in
            candidate.personInfo.name == savedPerson
        }
        guard let safeIndex = likedIndex else {
            return
        }
        people[safeIndex].isLiked = true
    }
}
