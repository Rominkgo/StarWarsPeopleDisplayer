//
//  ProfileViewModel.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/21/23.
//

import Foundation
import SwiftUI
import Combine


class ProfileViewModel: ObservableObject {
    
    private let datasource: RemoteDataSourceProtocol
    
    init(datasource: RemoteDataSourceProtocol) {
        self.datasource = datasource
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var peopleDetails: [PeopleDetails] = []
    @Published var errorHandler: String = ""
    @ObservedObject var vm: ContentViewModel = ContentViewModel(datasource: RemoteDataSource())
    
    func getPeopleDetailsData() {
        datasource.fetchStarWarsPeopleDetails()
            .sink { response in
                switch response {
                case .finished:
                    print("Call finish")
                case .failure:
                    self.errorHandler = "There was an error with the API"
                }
            } receiveValue: { [weak self] res in
                self?.peopleDetails.append(contentsOf: res)
            }
    }
    
    func matchCharacterDetails(person: LikablePerson) -> PeopleDetails {
        
        let originalPersonList = vm.people
        
        let newPersonIndex = peopleDetails.firstIndex { candidate in
            candidate.name == person.personInfo.name
        }
        
        guard let safeIndex = newPersonIndex else { return PeopleDetails(name: "None", homeworld: "none", gender: "none", image: "none", species: "none") }
        
        return peopleDetails[safeIndex]
    }
}
