//
//  FeedView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var gc: RideGroupCRUD

    @Binding var nomeRua : String
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    ForEach(gc.groups, id: \.self){ group in
                        NavigationLink{
                            GroupDetailsView(group: group)
                        }label: {
                            GroupRow(group: group)
                                .foregroundColor(.black)
                                .padding(.bottom, -24)
                        }
                    }
                }
                
                
            }
            .navigationTitle("Feed")
            .toolbar{
                NavigationLink{
                    CreateGroupView()
                }label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                }
                
            }
        }
        .onAppear(perform: {
            gc.fetchItems()
        })
    }
}


