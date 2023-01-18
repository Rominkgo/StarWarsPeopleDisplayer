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
    
    init() {
        self.likedPersonExists = UserDefaults.standard.bool(forKey: "likedPersonExists")
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var people: [LikablePerson] = []
    
    var likedPersonExists: Bool = false {
        didSet {
            UserDefaults.standard.set(likedPersonExists, forKey: "likedPersonExists")
        }
    }
    
    private let dataSource: RemoteDataSource = RemoteDataSource()
    
    func getPeopleData() {
        RemoteDataSource.shared.fetchStarWarsPeople("https://swapi.dev/api/people")
            .sink(receiveCompletion: {response in
                print("Good")
            }, receiveValue: { [weak self] res in
                let likeablePeople = res.map { person in
                   LikablePerson(personInfo: person, isLiked: false)
                }
                self?.people = likeablePeople
                self?.checkForLikedPerson()
            })
            .store(in: &cancellables )
    }
    
    func markPersonLiked(_ person: LikablePerson) {

        let likedIndex = people.firstIndex { candidate in
            candidate.personInfo.name == person.personInfo.name
        }
        guard let safeIndex = likedIndex else {
            return
        }
        
        if people.count >= safeIndex,
            likedPersonExists == false
        {
            print(person.personInfo.name + " Loved")
            people[safeIndex] = LikablePerson(personInfo: person.personInfo, isLiked: true)
            likedPersonExists = true
            UserDefaults.standard.set(person.personInfo.name, forKey: "FavouritePerson")
        }
    }
    
    func markPersonUnliked(_ person: LikablePerson) {
        let likedIndex = people.firstIndex { candidate in
            candidate.personInfo.name == person.personInfo.name
        }
        guard let safeIndex = likedIndex else {
            return
        }
        
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
