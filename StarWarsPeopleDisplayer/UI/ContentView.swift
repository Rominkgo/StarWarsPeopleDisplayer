//
//  ContentView.swift
//  StarWarsPeopleDisplayer
//
//  Created by David Castaneda on 1/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: ContentViewModel = ContentViewModel(datasource: RemoteDataSource())
    
    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            Text("Star Wars \n List of Characters")
                .multilineTextAlignment(.center)
                .font(.title)
            
            List {
                if vm.isLoading {
                    ProgressView()
                }
                
                ForEach(vm.people, id: \.personInfo.name) { person in
                    
 //                   HStack{

 //                       Spacer()
                        HStack {
                            NavigationLink(destination: ProfileView(profile: person))
                            {
                                Text("")
                                Text(person.personInfo.name)
                                    
                        
                            }
 //                           .contentShape(Rectangle())
//                            .buttonStyle(PlainButtonStyle())
                            
 //                           Spacer()
                            
                            if person.isLiked {
                                Button {
                                    vm.markPersonUnliked(person)
                                } label: {
                                    Image(systemName: "heart.fill")
                                }.padding()
                                    .contentShape(Rectangle())
                                    .buttonStyle(BorderlessButtonStyle())
                            } else {
                                Button {
                                    vm.markPersonLiked(person)
                                } label: {
                                    Image(systemName: "heart")
                                }.padding()
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                        
                    }
                    
                }
            }
            .onAppear(perform: { vm.getPeopleData() })
            .padding()
        }
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
