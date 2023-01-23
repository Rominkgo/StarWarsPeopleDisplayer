//
//  DetailsView.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/20/23.
//

import SwiftUI

struct ProfileView: View {

    var profile: LikablePerson
    @StateObject var vm: ProfileViewModel = ProfileViewModel(datasource: RemoteDataSource())
    
    
    var body: some View {
        
        VStack {
            Text("Character Profile")
                .padding()
                .font(.title)
            AsyncImage(url: URL(string: vm.matchCharacterDetails(person: profile).image))
                .frame(width: 250, height: 250, alignment: .center)
                .padding()
            Text(profile.personInfo.name)
            Text(profile.personInfo.gender)
            Text(vm.matchCharacterDetails(person: profile).homeworld)
//            Text(vm.matchCharacterDetails(person: profile).species)
        }
        .onAppear(perform: {vm.getPeopleDetailsData()})
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: LikablePerson(personInfo: People(name: "David", gender: "Male"), isLiked: false))
    }
}
