//
//  ContentView.swift
//  StarWarsPeopleDisplayer
//
//  Created by David Castaneda on 1/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: ContentViewModel = ContentViewModel(datasource: RemoteDataSource())
    
    var body: some View {
             
            VStack {
                
                Text("Star Wars \n List of Characters")
                    .multilineTextAlignment(.center)
                    .font(.title)
                
                List {
                    if vm.isLoading {
                        ProgressView()
                    }
                    ForEach(vm.people, id: \.personInfo.name) { person in
                        HStack{
                            Text(person.personInfo.name)
                            Spacer()
                            if person.isLiked {
                                Button {
                                    vm.markPersonUnliked(person)
                                } label: {
                                    Image(systemName: "heart.fill")
                                }
                            } else {
                                Button {
                                    vm.markPersonLiked(person)
                                } label: {
                                    Image(systemName: "heart")
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: { vm.getPeopleData() })
                .padding()
        }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
