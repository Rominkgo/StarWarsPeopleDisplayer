//
//  DetailsView.swift
//  StarWarsPeopleDisplayer
//
//  Created by Default on 1/20/23.
//

import SwiftUI

struct ProfileView: View {
    
    var profile: LikablePerson
    
    var body: some View {
        
        Text("ehllo")
        Text(profile.personInfo.gender)
        Text(profile.personInfo.name)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profile: LikablePerson(personInfo: People(name: "David", gender: "Male"), isLiked: false))
    }
}
