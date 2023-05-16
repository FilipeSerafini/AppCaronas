//
//  FeedView.swift
//  CaronasInicio
//
//  Created by Thiago Defini on 10/05/23.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    ForEach(groups, id: \.self){ group in
                        NavigationLink{
                            GroupDetailsView(group: group)
                        }label: {
                            GroupRow(group: group)
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
//                        .padding(.top, 50)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 30)
                }
                
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
